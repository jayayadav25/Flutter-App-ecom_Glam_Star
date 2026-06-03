import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/applied_coupon.dart';


class CouponNotifier extends StateNotifier<AppliedCouponModel?> {
  CouponNotifier() : super(null);

  void applyCoupon(AppliedCouponModel coupon) {
    state = coupon;
  }

  void clearCoupon() {
    state = null;
  }
}

final couponProvider =
StateNotifierProvider<CouponNotifier, AppliedCouponModel?>(
      (ref) => CouponNotifier(),
);
