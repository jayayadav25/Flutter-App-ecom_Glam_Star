import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistFirestoreService {

  final FirebaseFirestore firestore;

  WishlistFirestoreService(this.firestore,);

  CollectionReference<Map<String, dynamic>> wishlistRef(String uid) {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('wishlist');
  }
}