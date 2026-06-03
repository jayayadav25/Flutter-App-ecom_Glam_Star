import 'package:shared_preferences/shared_preferences.dart';

class PaymentDatasource {
  Future<void> savePaymentMethod(String method,) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('payment_method', method,);
  }
  Future<String?> getPaymentMethod() async {

    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(
      'payment_method',
    );
  }
}