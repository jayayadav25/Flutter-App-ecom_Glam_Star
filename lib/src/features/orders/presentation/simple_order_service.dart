import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SimpleOrderService {
  final _db = FirebaseFirestore.instance;

  Future<void> placeOrder({
    required double totalAmount,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not logged in");

    await _db.collection('orders').add({
      'userId': user.uid,
      'totalAmount': totalAmount,
      'createdAt': FieldValue.serverTimestamp(),
      'status': 'Placed',
    });
  }
}
