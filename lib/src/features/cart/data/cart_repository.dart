import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/models/cart_item_model.dart';
import '../../../core/models/product_model.dart';
import '../../../app/utils/constants.dart';

class CartRepository {
  late Box box;

  Future<void> init() async {
    if (Hive.isBoxOpen(AppConstants.cartBox)) {
      box = Hive.box(AppConstants.cartBox);
    } else {
      box = await Hive.openBox(AppConstants.cartBox);
    }
  }

  List<CartItemModel> getCart() {
    if (!box.isOpen) return [];

    return box.values.map((e) {
      return CartItemModel.fromMap(Map<String, dynamic>.from(e));
    }).toList();
  }

  Future<void> add(ProductModel product) async {
    final items = getCart();
    final index = items.indexWhere((i) => i.product.productId == product.productId);

    if (index != -1) {
      final updatedItem = CartItemModel(
        product: items[index].product,
        quantity: items[index].quantity + 1,
      );
      await box.putAt(index, updatedItem.toMap());
    } else {
      await box.add(
        CartItemModel(product: product, quantity: 1).toMap(),
      );
    }
  }

  Future<void> remove(String id) async {
    final index = getCart().indexWhere((i) => i.product.productId == id);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }

  Future<void> clear() async => await box.clear();

  // Increment
  Future<void> increment(String id) async {
    final items = getCart();
    final index = items.indexWhere((i) => i.product.productId == id);

    if (index != -1) {
      final updatedItem = CartItemModel(
        product: items[index].product,
        quantity: items[index].quantity + 1,
      );
      await box.putAt(index, updatedItem.toMap());
    }
  }

  // Decrement
  Future<void> decrement(String id) async {
    final items = getCart();
    final index = items.indexWhere((i) => i.product.productId == id);

    if (index != -1) {
      if (items[index].quantity > 1) {
        final updatedItem = CartItemModel(
          product: items[index].product,
          quantity: items[index].quantity - 1,
        );
        await box.putAt(index, updatedItem.toMap());
      } else {
        await box.deleteAt(index);
      }
    }
  }
}
