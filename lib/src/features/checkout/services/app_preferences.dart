import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {

  Future<void> setFirstOrderDone() async {

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setBool(
      'first_order_done',
      true,
    );
  }

  Future<bool> isFirstOrderDone() async {

    final prefs =
    await SharedPreferences.getInstance();

    return prefs.getBool(
      'first_order_done',
    ) ??
        false;
  }
}