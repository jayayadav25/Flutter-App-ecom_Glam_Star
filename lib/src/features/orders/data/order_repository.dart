// import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/order_model.dart';

abstract class OrderRepository {

  Future<String> createOrder(OrderModel order,);

  Stream<List<OrderModel>> getOrders(String userId,);
  Future<void> cancelOrder(String orderId,);
}
