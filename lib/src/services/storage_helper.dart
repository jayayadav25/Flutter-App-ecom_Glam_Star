// storage_helper.dart (updated)
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageHelper {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload a single file and return a map with url and path.
  Future<Map<String, String>> uploadFileWithPath({
    required String folder,
    required File file,
    String? filename,
    void Function(double progress)? onProgress,
  }) async {
    final name = filename ?? DateTime.now().millisecondsSinceEpoch.toString();
    final ref = _storage.ref().child('$folder/$name');

    final uploadTask = ref.putFile(file);

    final sub = uploadTask.snapshotEvents.listen((snap) {
      if (snap.totalBytes > 0 && onProgress != null) {
        onProgress(snap.bytesTransferred / snap.totalBytes);
      }
    });

    try {
      final snapshot = await uploadTask.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      final path = snapshot.ref.fullPath; // store file path for deletion later
      await sub.cancel();
      return {'url': url, 'path': path};
    } on FirebaseException catch (e) {
      await sub.cancel();
      throw FirebaseException(
        plugin: e.plugin,
        code: e.code,
        message: 'Upload failed: ${e.message}',
      );
    } catch (e) {
      await sub.cancel();
      rethrow;
    }
  }

  // Upload many files sequentially and return list of maps {url, path}
  Future<List<Map<String, String>>> uploadFilesWithPaths({
    required String folder,
    required List<File> files,
    void Function(int index, double progress)? onProgress,
  }) async {
    final results = <Map<String, String>>[];
    for (var i = 0; i < files.length; i++) {
      final file = files[i];
      final res = await uploadFileWithPath(
        folder: folder,
        file: file,
        filename: file.path.split('/').last,
        onProgress: (p) {
          if (onProgress != null) onProgress(i, p);
        },
      );
      results.add(res);
    }
    return results;
  }

  // delete by storage path
  Future<bool> safeDelete(String storagePath) async {
    try {
      await _storage.ref().child(storagePath).delete();
      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'object-not-found') return true;
      rethrow;
    }
  }
}
