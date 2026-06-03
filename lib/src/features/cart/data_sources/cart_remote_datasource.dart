import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/models/cart_item_model.dart';

class CartRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  CartRemoteDataSource({
    required this.firestore,
    required this.auth,
  });

  Future<void> syncCart(List<CartItemModel> items) async {
    final user = auth.currentUser;
    if (user == null) return;
    final cartRef = firestore
        .collection('users')
        .doc(user.uid)
        .collection('cart');

    final batch = firestore.batch();
    for (final item in items) {
      batch.set(
        cartRef.doc(item.productId),
        item.toMap(),
      );
    }

    await batch.commit();
  }

  Future<List<CartItemModel>> fetchCart() async {
    final user = auth.currentUser;
    if (user == null) return [];
    final snapshot = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .get();

    return snapshot.docs
        .map((e) => CartItemModel.fromMap(e.data()))
        .toList();
  }
}