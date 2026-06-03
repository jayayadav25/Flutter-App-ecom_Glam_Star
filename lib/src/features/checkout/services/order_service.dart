import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/user_request_model.dart';

class OrderService {
  final FirebaseFirestore firestore;

  OrderService({required this.firestore,});

  Future<void> placeOrder(OrderRequestModel order,) async {
    await firestore
        .collection('orders')
        .add({
      ...order.toMap(),
      'status': 'Placed',
      'createdAt':
      FieldValue.serverTimestamp(),
    });
  }
}












// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class OrderService {
//   final FirebaseFirestore firestore;
//   final FirebaseAuth auth;
//
//   OrderService({
//     required this.firestore,
//     required this.auth,
//   });
//
//   Future<void> placeOrder({
//     required List<Map<String, dynamic>> items,
//     required double total,
//     required String paymentMethod,
//   }) async {
//     final user = auth.currentUser;
//
//     if (user == null) {
//       throw Exception('User not logged in');
//     }
//
//     await firestore.collection('orders').add({
//       'userId': user.uid,
//       'items': items,
//       'total': total,
//       'paymentMethod': paymentMethod,
//       'status': 'Placed',
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//   }
// }