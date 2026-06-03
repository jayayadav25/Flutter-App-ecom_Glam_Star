import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/profile_providers.dart';

class ProfileController extends AsyncNotifier<void> {

  @override
  Future<void> build() async {}
  Future<void> updateProfileImage({required String uid,}) async {
    try {

      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (picked == null) return;
      final file = File(picked.path);
      final imageUrl = await ref.read(
        profileStorageServiceProvider,
      ).uploadProfileImage(
        uid: uid,
        file: file,
      );
      await ref.read(profileRepositoryProvider).updateProfile(
        uid: uid,
        data: {
          'profileImage': imageUrl,
        },
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateProfile({required String uid, required Map<String, dynamic> data,}) async {
    state = const AsyncLoading();
    try {
      await ref.read(profileRepositoryProvider).updateProfile(uid: uid, data: data,);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}