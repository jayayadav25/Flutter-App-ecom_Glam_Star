import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/order_model.dart';

class OrderRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String collection = 'orders';

  // Create order
  Future<String> createOrder(OrderModel order) async {
    final doc = await _db.collection(collection).add(order.toMap());
    return doc.id;
  }

  // Watch order user
  Stream<List<OrderModel>> watchOrders(String userId) {
    return _db
        .collection(collection)
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data(), doc.id))
          .toList(),
    );
  }
}
