import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/cart_item_model.dart';
import '../../../core/models/product_model.dart';
import '../data/cart_repository.dart';
import 'cart_selection_provider.dart';

class CartNotifier extends AsyncNotifier<List<CartItemModel>> {
  late CartRepository _repo;

  @override
  Future<List<CartItemModel>> build() async {
    _repo = CartRepository();
    await _repo.init();
    return _repo.getCart();
  }

  /// ✅ ADD TO CART (NO MANUAL SELECT HERE)
  void addToCart(ProductModel product) async {
    await _repo.add(product);
    state = AsyncData(_repo.getCart());
  }

  void removeFromCart(String id) async {
    await _repo.remove(id);
    state = AsyncData(_repo.getCart());
  }

  void increment(String id) async {
    await _repo.increment(id);
    state = AsyncData(_repo.getCart());
  }

  void decrement(String id) async {
    await _repo.decrement(id);
    state = AsyncData(_repo.getCart());
  }

  Future<void> clearCart() async {
    await _repo.clear();
    state = const AsyncData([]);
  }
}

/// MAIN PROVIDER
final cartProvider =
AsyncNotifierProvider<CartNotifier, List<CartItemModel>>(
  CartNotifier.new,
);

/// TOTAL CART PRICE
final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider).value ?? [];
  double total = 0;

  for (final item in cart) {
    total += item.product.sellingPrice * item.quantity;
  }
  return total;
});

/// CART ITEM COUNT (BADGE)
final cartCountProvider = Provider<int>((ref) {
  final cartAsync = ref.watch(cartProvider);

  return cartAsync.maybeWhen(
    data: (items) =>
        items.fold(0, (sum, item) => sum + item.quantity),
    orElse: () => 0,
  );
});

/// CHECK IF PRODUCT IS IN CART
final isInCartProvider =
Provider.family<bool, String>((ref, productId) {
  final cartAsync = ref.watch(cartProvider);

  return cartAsync.maybeWhen(
    data: (items) =>
        items.any((i) => i.product.productId == productId),
    orElse: () => false,
  );
});
