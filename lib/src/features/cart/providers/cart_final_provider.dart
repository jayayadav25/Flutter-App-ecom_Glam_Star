import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cart_total_provider.dart';
import 'coupon_providers.dart';

final finalAmountProvider = Provider<double>((ref) {
  final total = ref.watch(cartTotalProvider);
  final coupon = ref.watch(couponProvider);
  final discount = coupon?.discount ?? 0;
  final finalAmount = total - discount;
  return finalAmount < 0 ? 0 : finalAmount;
});
