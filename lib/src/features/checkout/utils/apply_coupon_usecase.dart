
import '../services/coupon_service.dart';

class ApplyCouponUsecase {

  double call(String code) {

    return CouponService
        .validateCoupon(code);
  }
}