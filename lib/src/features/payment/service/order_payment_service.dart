import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/order_model.dart';

class OrderPaymentService {
  final FirebaseFirestore firestore;

  OrderPaymentService({
    FirebaseFirestore? firestore,
  }) : firestore =
      firestore ??
          FirebaseFirestore.instance;

  Future<void> saveOrder(
      OrderModel order,
      ) async {
    await firestore
        .collection('orders')
        .doc(order.id)
        .set(order.toMap());
  }
}