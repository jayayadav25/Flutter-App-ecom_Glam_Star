
import '../../../core/models/cart_item_model.dart';
abstract class CartRepository {
  Future<List<CartItemModel>> getCart();
  Future<void> addToCart(CartItemModel item);
  Future<void> removeFromCart(String productId);
  Future<void> increment(String productId);
  Future<void> decrement(String productId);
  Future<void> clearCart();
  Future<void> syncCart();
}
