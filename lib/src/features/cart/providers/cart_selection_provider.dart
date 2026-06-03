import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartSelectionNotifier extends StateNotifier<Set<String>> {
  CartSelectionNotifier() : super({});

  void toggle(String productId) {
    final updated = {...state};

    if (updated.contains(productId)) {
      updated.remove(productId);
    } else {
      updated.add(productId);
    }

    state = updated;
  }

  void selectAll(List<String> ids) {
    state = ids.toSet();
  }

  void clear() {
    state = {};
  }

  bool isSelected(String productId) {
    return state.contains(productId);
  }
}

final cartSelectionProvider =
StateNotifierProvider<CartSelectionNotifier, Set<String>>(
      (ref) => CartSelectionNotifier(),
);
