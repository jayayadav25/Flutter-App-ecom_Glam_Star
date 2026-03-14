import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final walletProvider =
AsyncNotifierProvider<WalletNotifier, int>(WalletNotifier.new);

class WalletNotifier extends AsyncNotifier<int> {
  static const _key = 'wallet_points';

  @override
  Future<int> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key) ?? 0;
  }

  Future<void> addPoints(int points) async {
    final prefs = await SharedPreferences.getInstance();
    final newPoints = state.value! + points;
    await prefs.setInt(_key, newPoints);
    state = AsyncData(newPoints);
  }

  Future<void> redeemPoints(int points) async {
    final prefs = await SharedPreferences.getInstance();
    final newPoints = (state.value! - points).clamp(0, 999999);
    await prefs.setInt(_key, newPoints);
    state = AsyncData(newPoints);
  }
}
