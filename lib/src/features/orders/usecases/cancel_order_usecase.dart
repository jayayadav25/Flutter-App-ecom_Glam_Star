import '../data/order_repository.dart';


class CancelOrderUsecase {
  final OrderRepository repository;
  CancelOrderUsecase({
    required this.repository,
  });

  Future<void> call(String orderId,) {
    return repository.cancelOrder(
      orderId,
    );
  }
}