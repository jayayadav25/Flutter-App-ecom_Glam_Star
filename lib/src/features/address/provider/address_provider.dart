import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/address_model.dart';
import '../data/address_repository.dart';

// Firestore address provider (read only)
final addressProvider =
FutureProvider<List<AddressModel>>((ref) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return [];
  }

  final snap = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('addresses')
      .get();

  return snap.docs
      .map((d) => AddressModel.fromMap(d.id, d.data()))
      .toList();
});

final selectedAddressProvider =
StateProvider<AddressModel?>((ref) => null);
// Local (hive) address notifire
class AddressNotifier extends StateNotifier<List<AddressModel>> {
  final AddressRepository repo;

  AddressNotifier(this.repo) : super(repo.getAll());

  void add(AddressModel address) async {
    await repo.save(address);
    state = repo.getAll();
  }

  void delete(String id) async {
    await repo.delete(id);
    state = repo.getAll();
  }
}

// Selected address (checkout)
// final selectedAddressProvider =
// StateProvider<AddressModel?>((_) => null);
