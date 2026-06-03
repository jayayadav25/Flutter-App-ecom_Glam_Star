import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cart_providers.dart';

final cartTotalProvider = Provider<double>((ref) {
  final items = ref.watch(cartProvider).value ?? [];

  return items.fold(
    0,
        (sum, item) => sum + item.sellingTotal,
  );
});

final cartMrpTotalProvider = Provider<double>((ref) {
  final items = ref.watch(cartProvider).value ?? [];

  return items.fold(
    0,
        (sum, item) => sum + item.mrpTotal,
  );
});
