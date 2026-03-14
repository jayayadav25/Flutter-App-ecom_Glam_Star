import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/applied_coupon.dart';
import 'cart_providers.dart';

class AppliedCouponNotifier extends StateNotifier<AppliedCoupon?> {
  AppliedCouponNotifier(this.ref) : super(null);

  final Ref ref;

  void applyCoupon(AppliedCoupon coupon) {
    state = coupon;
  }

  void clearCoupon() {
    state = null;
  }
}

final appliedCouponProvider =
StateNotifierProvider<AppliedCouponNotifier, AppliedCoupon?>(
      (ref) {
    final notifier = AppliedCouponNotifier(ref);

    /// Auto-clear coupon when cart is empty
    ref.listen(cartProvider, (prev, next) {
      final items = next.value ?? [];
      if (items.isEmpty) {
        notifier.clearCoupon();
      }
    });

    return notifier;
  },
);
