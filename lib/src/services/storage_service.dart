import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage;
  final _uuid = Uuid();

  StorageService({FirebaseStorage? storage}) : _storage = storage ?? FirebaseStorage.instance;

  // Robust single file upload with a small retry for resumable session termination.
  // Returns {'url': downloadUrl, 'path': fullPath}
  Future<Map<String, String>> uploadProductImageRobust({
    required String productId,
    required File file,
    String? filename,
    String? categorySlug,
    Function(double progress)? onProgress, // receives [0..1]
    int maxRetries = 1,
  }) async {
    final name = filename ?? '${_uuid.v4()}${p.extension(file.path)}';
    final folder = (categorySlug != null && categorySlug.isNotEmpty)
        ? 'products/$categorySlug/$productId'
        : 'products/$productId';
    final ref = _storage.ref().child('$folder/$name');

    int attempt = 0;
    while (true) {
      attempt++;
      UploadTask? uploadTask;
      StreamSubscription<TaskSnapshot>? sub;
      try {
        print('[StorageService] Upload attempt #$attempt -> ref: ${ref.fullPath}, localFile: ${file.path}');
        uploadTask = ref.putFile(file);

        sub = uploadTask.snapshotEvents.listen((snap) {
          if (snap.totalBytes > 0 && onProgress != null) {
            final pProg = snap.bytesTransferred / snap.totalBytes;
            try {
              onProgress(pProg.clamp(0.0, 1.0));
            } catch (_) {}
          }
          // optional debug:
          // print('[StorageService] snapshot state=${snap.state} transferred=${snap.bytesTransferred}/${snap.totalBytes}');
        });

        final snapshot = await uploadTask.whenComplete(() => null);

        if (snapshot.state != TaskState.success) {
          // Not a success state — treat as failure to retry or surface
          throw FirebaseException(
            plugin: 'firebase_storage',
            code: 'upload-not-success',
            message: 'Upload finished with state ${snapshot.state}',
          );
        }

        final fullPath = snapshot.ref.fullPath;
        final downloadUrl = await snapshot.ref.getDownloadURL();

        await sub.cancel();
        print('[StorageService] Upload success -> fullPath: $fullPath, downloadUrl: $downloadUrl');
        return {'url': downloadUrl, 'path': fullPath};
      } on FirebaseException catch (e) {
        await (sub?.cancel());
        final code = (e.code ?? '').toLowerCase();
        final message = e.message ?? '';
        print('[StorageService] Upload attempt #$attempt failed: code=$code message=$message');

        // Server-side resumable-session termination / Not Found often shows as 404 or object-not-found.
        final isSessionTerminated = message.contains('Not Found') ||
            code.contains('not-found') ||
            code == 'object-not-found' ||
            code == '404' ||
            (message.contains('terminated') || message.contains('terminated the upload'));

        if (isSessionTerminated && attempt <= maxRetries + 1) {
          // Try a short backoff and retry
          print('[StorageService] Resumable session terminated — retrying upload (next attempt ${attempt + 1}) ...');
          await Future.delayed(const Duration(milliseconds: 350 * 1)); // tiny backoff
          continue; // next attempt
        }

        // If it's a permission / app-check error or other unrecoverable, rethrow a clear FirebaseException
        throw FirebaseException(
          plugin: e.plugin ?? 'firebase_storage',
          code: e.code ?? 'upload-error',
          message: 'Upload failed (attempt $attempt): ${e.message} (ref: ${ref.fullPath})',
        );
      } catch (e) {
        await (sub?.cancel());
        print('[StorageService] Upload attempt #$attempt unknown error: $e');
        if (attempt <= maxRetries) {
          await Future.delayed(const Duration(milliseconds: 350));
          continue;
        }
        rethrow;
      } finally {
        // ensure subscription is cancelled if still active
        try {
          await sub?.cancel();
        } catch (_) {}
      }
    }
  }

  // Upload multiple files sequentially; returns list of {'url','path'} in same order.
  Future<List<Map<String, String>>> uploadProductImages({
    required String productId,
    required List<File> files,
    String? categorySlug,
    Function(int index, double progress)? onProgress,
    int maxRetriesPerFile = 1,
  }) async {
    final results = <Map<String, String>>[];
    for (var i = 0; i < files.length; i++) {
      final file = files[i];
      final res = await uploadProductImageRobust(
        productId: productId,
        file: file,
        filename: p.basename(file.path),
        categorySlug: categorySlug,
        onProgress: (p) {
          if (onProgress != null) onProgress(i, p);
        },
        maxRetries: maxRetriesPerFile,
      );
      results.add(res);
      // slight delay to avoid hammering backend quickly
      await Future.delayed(const Duration(milliseconds: 50));
    }
    return results;
  }

  // General upload of bytes
  Future<Map<String, String>> uploadBytes({
    required Uint8List bytes,
    required String fileName,
    required String folder,
    String contentType = "image/jpeg",
  }) async {
    final ref = _storage.ref().child('$folder/$fileName');
    final metadata = SettableMetadata(contentType: contentType);
    final task = ref.putData(bytes, metadata);

    final snapshot = await task.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();
    return {'url': url, 'path': snapshot.ref.fullPath};
  }

  // Delete by either storage fullPath or download URL or gs:// URL; tolerant of not-found.
  Future<void> deleteFile(String storagePathOrUrl) async {
    try {
      Reference ref;
      if (storagePathOrUrl.startsWith('http')) {
        final extracted = _extractPathFromDownloadUrl(storagePathOrUrl);
        if (extracted != null) {
          ref = _storage.ref().child(extracted);
        } else {
          ref = _storage.refFromURL(storagePathOrUrl);
        }
      } else if (storagePathOrUrl.startsWith('gs://')) {
        ref = _storage.refFromURL(storagePathOrUrl);
      } else {
        ref = _storage.ref().child(storagePathOrUrl);
      }

      try {
        await ref.getMetadata();
      } on FirebaseException catch (e) {
        final code = (e.code ?? '').toLowerCase();
        if (code.contains('not-found') || code == 'object-not-found' || code == '404') {
          print('[StorageService] deleteFile: object not found for ${ref.fullPath} - treating as success');
          return;
        }
        rethrow;
      }

      await ref.delete();
      print('[StorageService] deleteFile: deleted ${ref.fullPath}');
    } on FirebaseException catch (e) {
      print('[StorageService] deleteFile: FirebaseException ${e.code} ${e.message}');
      rethrow;
    } catch (e) {
      print('[StorageService] deleteFile: unexpected error $e');
      rethrow;
    }
  }

  // Resolve a stored path (fullPath) OR a download URL to a usable download URL.
  // Returns null if the object doesn't exist or permission denied.
  Future<String?> safeGetDownloadUrl(String storagePathOrUrl) async {
    try {
      Reference ref;
      if (storagePathOrUrl.startsWith('http')) {
        // assume it's already a valid download URL
        return storagePathOrUrl;
      } else if (storagePathOrUrl.startsWith('gs://')) {
        ref = _storage.refFromURL(storagePathOrUrl);
      } else {
        ref = _storage.ref().child(storagePathOrUrl);
      }

      // ensure exists
      await ref.getMetadata();
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      final code = (e.code ?? '').toLowerCase();
      print('[StorageService] safeGetDownloadUrl: error code=$code message=${e.message} for "$storagePathOrUrl"');
      if (code.contains('not-found') || code == 'object-not-found' || code == '404') {
        return null;
      }
      return null;
    } catch (e) {
      print('[StorageService] safeGetDownloadUrl: unexpected error $e for "$storagePathOrUrl"');
      return null;
    }
  }

  // Try to extract fullPath from firebase download URL
  String? _extractPathFromDownloadUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final segments = uri.pathSegments;
      final oIndex = segments.indexOf('o');
      if (oIndex >= 0 && oIndex < segments.length - 1) {
        final encoded = segments.sublist(oIndex + 1).join('/');
        final decoded = Uri.decodeComponent(encoded);
        return decoded;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
