import 'package:firebase_mastery_app/src/app/theme/app_theme.dart';
import 'package:firebase_mastery_app/src/app/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/providers/auth_state_provider.dart';
import 'router.dart';

class App extends ConsumerWidget {
  const App({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final router = ref.watch(appRouterProvider);
    final authState = ref.watch(authStateProvider);
    final themeMode = ref.watch(themeProvider);
    return authState.when(
      data: (_) {
        return MaterialApp.router(
          title: 'Glam Star',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,

          routerConfig: router,
        );
      },
      loading: () {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
      error: (e, st) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(
              child: Text(
                e.toString(),
              ),
            ),
          ),
        );
      },
    );
  }
}

