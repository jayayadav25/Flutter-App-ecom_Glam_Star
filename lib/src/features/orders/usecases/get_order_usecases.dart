import '../../../core/models/order_model.dart';
import '../data/order_repository.dart';

class GetOrdersUsecase {

  final OrderRepository repository;

  GetOrdersUsecase({required this.repository,});

  Stream<List<OrderModel>> call(String userId,) {
    return repository.getOrders(
      userId,
    );
  }
}
