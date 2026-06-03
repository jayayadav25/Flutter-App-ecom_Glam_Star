import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletNotifier extends AsyncNotifier<int> {
  static const walletKey = 'wallet_points';

  @override
  Future<int> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(walletKey) ?? 0;
  }

  Future<void> addPoints(int points) async {
    final prefs = await SharedPreferences.getInstance();
    final current = state.value ?? 0;
    final updated = current + points;
    await prefs.setInt(walletKey, updated);
    state =AsyncData(updated);
  }

  Future<void> redeemPoints(int points) async {
    final prefs = await SharedPreferences.getInstance();
    final current = state.value ?? 0;
    final updated = (current - points).clamp(0, 999999);
    await prefs.setInt(walletKey, updated);
    state = AsyncData(updated);
  }
}

final walletProvider =
AsyncNotifierProvider<WalletNotifier, int>(
  WalletNotifier.new,
);
