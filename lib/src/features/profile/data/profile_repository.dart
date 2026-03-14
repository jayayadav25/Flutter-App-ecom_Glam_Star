import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/firestore_service.dart';
import '../../../core/models/user_model.dart';
import '../../../core/providers/firebase_providers.dart';

class ProfileRepository {
  final FirestoreService _firestore;
  static const String usersCollection = 'users';

  ProfileRepository(this._firestore);

  // watch user document
  Stream<UserModel?> watchUser(String uid) {
    return _firestore.watchDocument(
      collectionPath: usersCollection,
      docId: uid,
    ).map((doc) {
      if (!doc.exists) return null;
      return UserModel.fromMap(doc.data()!, doc.id);
    });
  }

  // Update user data
  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    await _firestore.updateDocument(
      collectionPath: usersCollection,
      docId: uid,
      data: data,
    );
  }
}

// Missing provider
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final firestore = ref.read(firestoreServiceProvider);
  return ProfileRepository(firestore);
});
