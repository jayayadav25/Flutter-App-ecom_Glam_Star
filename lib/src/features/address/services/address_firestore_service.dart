import 'package:cloud_firestore/cloud_firestore.dart';

class AddressFirestoreService {
  final FirebaseFirestore firestore;

  AddressFirestoreService(this.firestore);

  CollectionReference<Map<String, dynamic>> addressRef(String uid) {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('addresses');
  }
}