import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'checkout_provider.dart';
import 'shipping_provider.dart';
import 'subtotal_provider.dart';

final checkoutTotalProvider =
Provider<double>((ref) {

  final subtotal = ref.watch(subtotalProvider);
  final shipping = ref.watch(shippingProvider);
  final checkout = ref.watch(checkoutProvider);
  return subtotal + shipping - checkout.couponDiscount;
});