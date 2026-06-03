import '../../../core/models/user_request_model.dart';
import '../services/order_service.dart';

class CheckoutRemoteDatasource {

  final OrderService orderService;

  CheckoutRemoteDatasource({
    required this.orderService,
  });

  Future<void> placeOrder(OrderRequestModel order,) {
    return orderService.placeOrder(order);
  }
}