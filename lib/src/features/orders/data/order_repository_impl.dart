import '../../../core/models/order_model.dart';
import '../datasources/order_remote_datasources.dart';
import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {

  final OrderRemoteDatasource remote;
  OrderRepositoryImpl({
    required this.remote,
  });

  @override
  Future<String> createOrder(OrderModel order,) {
    return remote.createOrder(order,);
  }

  @override
  Stream<List<OrderModel>> getOrders(String userId,) {
    return remote.getOrders(userId,);
  }

  @override
  Future<void> cancelOrder(String orderId,) {
    return remote.cancelOrder(orderId,);
  }
}