import 'package:flutter_riverpod/flutter_riverpod.dart';

final priceAlertProvider =
StateNotifierProvider<PriceAlertNotifier, Set<String>>(
      (ref) => PriceAlertNotifier(),
);

class PriceAlertNotifier extends StateNotifier<Set<String>> {
  PriceAlertNotifier() : super({});

  void toggleAlert(String productId) {
    if (state.contains(productId)) {
      state = {...state}..remove(productId);
    } else {
      state = {...state, productId};
    }
  }

  bool isAlertEnabled(String productId) {
    return state.contains(productId);
  }
}
