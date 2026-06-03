import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/order_model.dart';

class OrderRemoteDatasource {
  final FirebaseFirestore firestore;
  OrderRemoteDatasource({
    required this.firestore,
  });

  // CREATE ORDER
  Future<String> createOrder(OrderModel order,) async {
    final doc = await firestore.collection('orders').add(order.toMap());
    return doc.id;
  }
  // GET USER ORDERS ONLY
  Stream<List<OrderModel>> getOrders(String userId,) {
    return firestore.collection('orders')
    // FILTER USER ORDERS
        .where('userId', isEqualTo: userId,)
    // LATEST FIRST
        .orderBy('createdAt', descending: true,)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return OrderModel.fromMap(data, doc.id,);

      }).toList();
    });
  }

  // CANCEL ORDER
  Future<void> cancelOrder(String orderId,) async {
    await firestore.collection('orders').doc(orderId)
        .update({'status': 'Cancelled',});
  }
}