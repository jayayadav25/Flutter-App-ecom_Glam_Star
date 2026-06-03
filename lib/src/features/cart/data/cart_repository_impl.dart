import '../../../core/models/cart_item_model.dart';
import '../data_sources/cart_local_datasources.dart';
import '../data_sources/cart_remote_datasource.dart';
import 'cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource local;
  final CartRemoteDataSource remote;

  CartRepositoryImpl({
    required this.local,
    required this.remote,
  });

  List<CartItemModel> _items = [];

  @override
  Future<List<CartItemModel>> getCart() async {
    _items = local.getCartItems();
    return _items;
  }

  @override
  Future<void> addToCart(CartItemModel item) async {
    final index = _items.indexWhere(
          (e) => e.productId == item.productId,
    );

    if (index != -1) {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity + 1,
      );
    } else {
      _items.add(item);
    }

    await local.saveCart(_items);
    await remote.syncCart(_items);
  }

  @override
  Future<void> removeFromCart(String productId) async {
    _items.removeWhere((e) => e.productId == productId);

    await local.saveCart(_items);
    await remote.syncCart(_items);
  }

  @override
  Future<void> increment(String productId) async {
    final index = _items.indexWhere(
          (e) => e.productId == productId,
    );

    if (index == -1) return;

    _items[index] = _items[index].copyWith(
      quantity: _items[index].quantity + 1,
    );

    await local.saveCart(_items);
    await remote.syncCart(_items);
  }

  @override
  Future<void> decrement(String productId) async {
    final index = _items.indexWhere(
          (e) => e.productId == productId,
    );

    if (index == -1) return;

    final item = _items[index];

    if (item.quantity <= 1) {
      _items.removeAt(index);
    } else {
      _items[index] = item.copyWith(
        quantity: item.quantity - 1,
      );
    }

    await local.saveCart(_items);
    await remote.syncCart(_items);
  }

  @override
  Future<void> clearCart() async {
    _items.clear();
    await local.clearCart();
    await remote.syncCart([]);
  }

  @override
  Future<void> syncCart() async {
    await remote.syncCart(_items);
  }
}