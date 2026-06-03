import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileStorageService {

  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<String> uploadProfileImage({
    required String uid,
    required File file,
  }) async {

    final ref = storage.ref().child('profile_images/$uid.jpg',);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}