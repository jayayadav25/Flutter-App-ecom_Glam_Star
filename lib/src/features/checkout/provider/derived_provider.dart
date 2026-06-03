import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../cart/providers/cart_providers.dart';
import 'checkout_provider.dart';

final subtotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider).value ?? [];

  return cart.fold(
    0,
        (sum, item) => sum + item.sellingTotal,
  );
});

final shippingProvider = Provider<double>((ref) {
  final subtotal = ref.watch(subtotalProvider);

  if (subtotal > 3000) {
    return 0;
  }

  return 49;
});

final totalProvider = Provider<double>((ref) {
  final subtotal = ref.watch(subtotalProvider);

  final shipping = ref.watch(shippingProvider);

  final checkout = ref.watch(checkoutProvider);

  return subtotal + shipping - checkout.couponDiscount;
});