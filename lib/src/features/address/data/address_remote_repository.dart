import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/address_model.dart';

class AddressRemoteRepository {
  final FirebaseFirestore firestore;

  AddressRemoteRepository(this.firestore);

  CollectionReference<Map<String, dynamic>> _addressRef(String uid,) {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('addresses');
  }

  Future<List<AddressModel>> getAddresses(String uid,) async {
    final snap = await _addressRef(uid)
        .orderBy('createdAt', descending: true,).get();

    return snap.docs.map((doc) => AddressModel.fromMap(doc.id, doc.data(),),
    ).toList();
  }

  Future<void> addAddress({
    required String uid,
    required AddressModel address,
  }) async {
    final ref = _addressRef(uid);
    final existing = await ref.get();
    bool isDefault = address.isDefault;
    // First address auto default
    if (existing.docs.isEmpty) {
      isDefault = true;
    }
    // Remove old default
    if (isDefault) {
      await _removePreviousDefault(uid);
    }
    await ref.doc(address.id).set({...address.toMap(), 'isDefault': isDefault,});
  }

  Future<void> setDefaultAddress({required String uid, required String addressId,}) async {
    final ref = _addressRef(uid);
    final snap = await ref.get();
    for (final doc in snap.docs) {
      await doc.reference.update({'isDefault': false,});}
    await ref.doc(addressId).update({'isDefault': true,});
  }

  Future<void> updateAddress({required String uid, required AddressModel address,}) async {
    if (address.isDefault) {
      await _removePreviousDefault(uid);
    }
    await _addressRef(uid).doc(address.id).update(address.toMap());
  }

  Future<void> deleteAddress({required String uid, required String addressId,}) async {
    await _addressRef(uid).doc(addressId).delete();
  }

  Future<void> _removePreviousDefault(String uid,) async {
    final snap = await _addressRef(uid).where('isDefault', isEqualTo: true,).get();

    for (final doc in snap.docs) {
      await doc.reference.update({
        'isDefault': false,
      });
    }
  }
}