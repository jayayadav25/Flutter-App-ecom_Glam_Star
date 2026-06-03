import 'package:hive_flutter/hive_flutter.dart';

class OrderLocalDatasource {
  static const boxName = 'recent_orders';
  Future<void> saveRecentOrder(String orderId,) async {
    final box = await Hive.openBox(boxName,);
    final List existing = box.get('orders', defaultValue: [],);
    existing.add(orderId);
    await box.put('orders', existing,);
  }
  Future<List<String>> getRecentOrders() async {
    final box = await Hive.openBox(boxName,);
    return List<String>.from(
      box.get(
        'orders',
        defaultValue: [],
      ),
    );
  }
}