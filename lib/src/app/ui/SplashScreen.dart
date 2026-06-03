import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _controller.forward();

   // navigation
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      final loggedIn = prefs.getBool('logged_in') ?? false;
      final onboardingDone = prefs.getBool('onboarding') ?? false;

      await Future.delayed(const Duration(milliseconds: 1600));

      if (!mounted) return;

      if (!onboardingDone) {
        context.go('/onboarding');
      } else if (loggedIn) {
        context.go('/home');
      } else {
        context.go('/login');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FadeTransition(
        opacity: _fade,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: 'logo',
                child: SizedBox(
                  width: size.width * 0.8,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset("assets/logo.png"),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
