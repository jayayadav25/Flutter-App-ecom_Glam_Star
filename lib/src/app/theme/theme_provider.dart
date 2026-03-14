import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider =
StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light) {
    _loadTheme();
  }

  static const String _themeKey = 'selected_theme';

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_themeKey);
      if (saved != null) {
        state = ThemeMode.values.firstWhere(
              (mode) => mode.toString() == saved,
          orElse: () => ThemeMode.light,
        );
      }
    } catch (_) {
      state = ThemeMode.light;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.toString());
  }

  Future<void> setAppTheme(AppThemeType type) async {
    switch (type) {
      case AppThemeType.dark:
        await setThemeMode(ThemeMode.dark);
        break;
      case AppThemeType.light:
        await setThemeMode(ThemeMode.light);
        break;
      case AppThemeType.gold:
      case AppThemeType.purple:
      case AppThemeType.red:
        await setThemeMode(ThemeMode.light);
        break;
    }
  }
}
