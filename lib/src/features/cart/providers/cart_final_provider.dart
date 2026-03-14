import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cart_selected_total_provider.dart';
import 'coupon_providers.dart';

final finalPayableAmountProvider = Provider<double>((ref) {
  final selectedSellingTotal =
  ref.watch(selectedSellingTotalProvider);

  // ✅ appliedCouponProvider is NOT AsyncValue
  final coupon = ref.watch(appliedCouponProvider);
  final couponDiscount = coupon?.discount ?? 0;

  const double convenienceCharge = 0;

  final total =
      selectedSellingTotal - couponDiscount + convenienceCharge;

  return total < 0 ? 0 : total;
});
