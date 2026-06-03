import '../../../core/models/order_model.dart';

import '../data/order_repository.dart';

class CreateOrderUsecase {
  final OrderRepository repository;

  CreateOrderUsecase({
    required this.repository,
  });

  Future<String> call(OrderModel order,) {
    return repository.createOrder(
      order,
    );
  }
}