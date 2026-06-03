import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/address_model.dart';
import '../controllers/address_controllers.dart';
import '../data/address_remote_repository.dart';
import '../services/address_firestore_service.dart';

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final addressFirestoreServiceProvider = Provider<AddressFirestoreService>((ref) {
  return AddressFirestoreService(
    ref.read(firestoreProvider),
  );
});

final addressRemoteRepoProvider = Provider<AddressRemoteRepository>((ref) {
  return AddressRemoteRepository(
    ref.read(firestoreProvider),
  );
});

final addressProvider = FutureProvider<List<AddressModel>>((ref) async {

  final user = ref.read(firebaseAuthProvider).currentUser;
  if (user == null) return [];
  return ref.read(addressRemoteRepoProvider).getAddresses(user.uid);
});

final selectedAddressProvider = StateProvider<AddressModel?>((ref) => null,);

final addressControllerProvider = AsyncNotifierProvider<AddressController, void>(
  AddressController.new,
);
