import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_provider.dart';
import 'app_theme.dart';

class ThemeSwitcherScreen extends ConsumerWidget {
  const ThemeSwitcherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Theme"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _tile(
            context: context,
            ref: ref,
            label: "Light Theme",
            theme: AppThemeType.light,
            selected: currentTheme == ThemeMode.light,
          ),
          _tile(
            context: context,
            ref: ref,
            label: "Dark Theme",
            theme: AppThemeType.dark,
            selected: currentTheme == ThemeMode.dark,
          ),
          // _tile(
          //   context: context,
          //   ref: ref,
          //   label: "Gold Theme",
          //   theme: AppThemeType.gold,
          //   selected: currentTheme == ThemeMode.system,
          // ),
          // _tile(
          //   context: context,
          //   ref: ref,
          //   label: "Purple Theme",
          //   theme: AppThemeType.purple,
          //   selected: false,
          // ),
          // _tile(
          //   context: context,
          //   ref: ref,
          //   label: "Red Theme",
          //   theme: AppThemeType.red,
          //   selected: false,
          // ),
        ],
      ),
    );
  }

  Widget _tile({
    required BuildContext context,
    required WidgetRef ref,
    required String label,
    required AppThemeType theme,
    required bool selected,
  }) {
    return ListTile(
      title: Text(label),
      trailing: selected ? const Icon(Icons.check, color: Colors.green) : null,
      onTap: () {
        ref.read(themeProvider.notifier).setAppTheme(theme);
      },
    );
  }
}
