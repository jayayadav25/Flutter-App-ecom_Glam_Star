import '../../../core/models/user_request_model.dart';

abstract class CheckoutRepository {

  Future<void> placeOrder(
      OrderRequestModel order,
      );

  Future<void> saveCoupon(
      String code,
      );

  Future<String?> getCoupon();
}