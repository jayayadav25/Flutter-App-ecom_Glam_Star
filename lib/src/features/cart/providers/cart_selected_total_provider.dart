import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cart_providers.dart';
import 'cart_selection_provider.dart';

final selectedCartTotalProvider = Provider<double>((ref) {
  final items = ref.watch(cartProvider).value ?? [];
  final selectedIds = ref.watch(cartSelectionProvider);

  double total = 0;

  for (final item in items) {
    if (selectedIds.contains(item.productId)) {
      total += item.sellingTotal;
    }
  }

  return total;
});
