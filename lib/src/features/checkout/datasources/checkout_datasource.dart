import 'package:hive/hive.dart';

class CheckoutLocalDatasource {
  static const _boxName = 'checkout_box';
  Future<void> saveCoupon(String code,) async {
    final box = await Hive.openBox(_boxName);
    await box.put('coupon_code', code,);
  }

  Future<String?> getCoupon() async {
    final box = await Hive.openBox(_boxName);
    return box.get('coupon_code');
  }
}