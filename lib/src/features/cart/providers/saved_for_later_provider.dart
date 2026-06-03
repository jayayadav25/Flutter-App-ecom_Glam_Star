import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/product_model.dart';

final savedForLaterProvider = StateNotifierProvider<SavedForLaterNotifier, List<ProductModel>>(
      (ref) => SavedForLaterNotifier(),
);

class SavedForLaterNotifier extends StateNotifier<List<ProductModel>> {
  SavedForLaterNotifier() : super([]);

  void save(ProductModel product) {
    if (!state.any((p) => p.productId == product.productId)) {
      state = [...state, product];
    }
  }

  void remove(String productId) {
    state = state.where((p) => p.productId != productId).toList();
  }
}
