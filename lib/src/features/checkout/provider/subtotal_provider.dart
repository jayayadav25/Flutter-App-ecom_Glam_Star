import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cart/providers/cart_providers.dart';

final subtotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider).value ?? [];
  return cart.fold(0, (sum, item) => sum + item.sellingTotal,);
});