import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/models/cart_item_model.dart';
import '../../../app/utils/constants.dart';

class CartLocalDataSource {

  // USE ALREADY OPENED BOX
  final Box box = Hive.box(AppConstants.cartBox);
  List<CartItemModel> getCartItems() {
    return box.values.map((e) {
      return CartItemModel.fromMap(
        Map<String, dynamic>.from(e),
      );
    }).toList();
  }

  Future<void> saveCart(List<CartItemModel> items,) async {
    await box.clear();
    for (final item in items) {
      await box.add(item.toMap());
    }
  }

  Future<void> clearCart() async {
    await box.clear();
  }
}