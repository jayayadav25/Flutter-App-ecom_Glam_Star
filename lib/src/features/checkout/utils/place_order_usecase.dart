import '../../../core/models/user_request_model.dart';
import '../repository/checkout_repository.dart';

class PlaceOrderUsecase {
  final CheckoutRepository repository;
  PlaceOrderUsecase({required this.repository,
  });

  Future<void> call(OrderRequestModel order,) {
    return repository.placeOrder(
      order,
    );
  }
}