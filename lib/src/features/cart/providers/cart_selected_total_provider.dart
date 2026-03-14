import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_providers.dart';
import '../providers/cart_selection_provider.dart';

final selectedCartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider).value ?? [];
  final selectedIds = ref.watch(cartSelectionProvider);

  double total = 0;

  for (final item in cart) {
    if (selectedIds.contains(item.product.productId)) {
      total += item.sellingTotal;
    }
  }

  return total;
});
// final selectedCartTotalProvider = Provider<double>((ref) {
//   final cartAsync = ref.watch(cartProvider);
//   final selectedIds = ref.watch(cartSelectionProvider);
//
//   return cartAsync.maybeWhen(
//     data: (items) {
//       double total = 0;
//
//       for (final item in items) {
//         if (selectedIds.contains(item.product.productId)) {
//           total += item.product.sellingPrice * item.quantity;
//         }
//       }
//
//       return total;
//     },
//     orElse: () => 0,
//   );
// });

final selectedMrpTotalProvider = Provider<double>((ref) {
  final cartAsync = ref.watch(cartProvider);
  final selectedIds = ref.watch(cartSelectionProvider);

  return cartAsync.maybeWhen(
    data: (items) => items
        .where((item) => selectedIds.contains(item.product.productId))
        .fold(0.0, (sum, item) => sum + item.mrpTotal),
    orElse: () => 0.0,
  );
});

/// ✅ Selected Selling Total
final selectedSellingTotalProvider = Provider<double>((ref) {
  final cartAsync = ref.watch(cartProvider);
  final selectedIds = ref.watch(cartSelectionProvider);

  return cartAsync.maybeWhen(
    data: (items) => items
        .where((item) => selectedIds.contains(item.product.productId))
        .fold(0.0, (sum, item) => sum + item.sellingTotal),
    orElse: () => 0.0,
  );
});