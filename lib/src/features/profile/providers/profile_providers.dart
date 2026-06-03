import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/user_model.dart';
import '../../auth/providers/auth_providers.dart';
import '../controllers/profile_controllers.dart';
import '../data/profile_repository.dart';
import '../widgets/profile_storage.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository( ref.read(firestoreProvider),
  );
});

final currentUserProvider = StreamProvider<UserModel?>((ref) {
  final firebaseUser = ref.watch(authStateChangesProvider).asData?.value;

  if (firebaseUser == null) {
    return const Stream.empty();
  }

  return ref.read(profileRepositoryProvider).watchUser(firebaseUser.uid);
});

final profileControllerProvider = AsyncNotifierProvider<ProfileController, void>(ProfileController.new,);

final profileStorageServiceProvider = Provider((ref) => ProfileStorageService(),);

