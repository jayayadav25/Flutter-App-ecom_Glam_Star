import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/profile_repository.dart';
import '../../../core/models/user_model.dart';
import '../../auth/providers/auth_providers.dart';


// Watch current Firebase user profile
final currentUserProvider = StreamProvider<UserModel?>((ref) {
  final firebaseUser = ref.watch(authStateChangesProvider).asData?.value;

  if (firebaseUser == null) {
    return const Stream.empty();
  }

  final repo = ref.read(profileRepositoryProvider);
  return repo.watchUser(firebaseUser.uid);
});


// Profile update controller

final updateProfileProvider = Provider<UpdateProfileController>((ref) {
  return UpdateProfileController(ref);
});

class UpdateProfileController {
  final Ref ref;

  UpdateProfileController(this.ref);

  Future<void> updateProfile({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    final repo = ref.read(profileRepositoryProvider);
    await repo.updateProfile(uid, data);
  }
}
