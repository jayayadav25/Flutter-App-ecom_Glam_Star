import 'package:firebase_mastery_app/src/features/checkout/provider/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/apply_coupon_usecase.dart';
import '../utils/checkout_user_usecase.dart';
import '../utils/place_order_usecase.dart';
import '../utils/validate_checout_usecase.dart';

final calculateCheckoutUsecaseProvider = Provider<CalculateCheckoutUsecase>((ref) {
  return CalculateCheckoutUsecase();
});

final applyCouponUsecaseProvider = Provider<ApplyCouponUsecase>((ref) {
  return ApplyCouponUsecase();
});

final validateCheckoutUsecaseProvider = Provider<ValidateCheckoutUsecase>((ref) {
  return ValidateCheckoutUsecase();
});

final placeOrderUsecaseProvider = Provider<PlaceOrderUsecase>((ref) {

  return PlaceOrderUsecase(

    repository:
    ref.watch(
      checkoutRepositoryProvider,
    ),
  );
});