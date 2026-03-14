import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cart_providers.dart';

class CartSelectionNotifier extends StateNotifier<Set<String>> {
  CartSelectionNotifier(this.ref) : super(<String>{}) {
    ref.listen(cartProvider, (prev, next) {
      final items = next.value ?? [];

      /// ✅ CONVERT productId (int) → String
      final cartIds = items
          .map((e) => e.product.productId.toString())
          .toSet();

      // 🟥 Cart empty → clear selection
      if (items.isEmpty) {
        state = {};
        return;
      }

      // 🟢 FIRST LOAD AFTER APP START
      if ((prev?.value ?? []).isEmpty && state.isEmpty) {
        state = {...cartIds};
        return;
      }

      // 🟢 NEW ITEMS ADDED → auto-select only them
      final newlyAdded = cartIds.difference(state);
      if (newlyAdded.isNotEmpty) {
        state = {...state, ...newlyAdded};
      }

      // 🟥 REMOVE SELECTION FOR REMOVED ITEMS
      state = state.intersection(cartIds);
    });
  }

  final Ref ref;

  /// Checkbox toggle (manual control)
  void toggle(String productId) {
    final s = {...state};
    s.contains(productId) ? s.remove(productId) : s.add(productId);
    state = s;
  }

  bool isSelected(String productId) {
    return state.contains(productId);
  }
}

final cartSelectionProvider =
StateNotifierProvider<CartSelectionNotifier, Set<String>>(
      (ref) => CartSelectionNotifier(ref),
);
