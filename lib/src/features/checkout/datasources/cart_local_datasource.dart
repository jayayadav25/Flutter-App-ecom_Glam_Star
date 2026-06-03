import 'package:hive/hive.dart';

class CartLocalDatasource {
  static const _boxName = 'cart_box';
  Future<void> saveCart(
      List<Map<String, dynamic>> cart,) async {
    final box = await Hive.openBox(_boxName);
    await box.put('cart_items', cart,);
  }
  Future<List<dynamic>> getCart() async {
    final box = await Hive.openBox(_boxName);
    return box.get('cart_items',
      defaultValue: [],) ?? [];
  }

  Future<void> clearCart() async {
    final box = await Hive.openBox(_boxName);
    await box.delete('cart_items',);
  }
}