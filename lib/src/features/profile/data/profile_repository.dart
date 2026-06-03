import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/user_model.dart';

class ProfileRepository {
  final FirebaseFirestore firestore;

  ProfileRepository(this.firestore);

  Stream<UserModel?> watchUser(String uid) {
    return firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) {
      if (!doc.exists) return null;

      return UserModel.fromMap(
        doc.data()!,
        doc.id,
      );
    });
  }

  Future<void> updateProfile({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    await firestore
        .collection('users')
        .doc(uid)
        .update(data);
  }
}
