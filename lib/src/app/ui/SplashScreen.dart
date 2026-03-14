import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
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
    return Scaffold(
      body: FadeTransition(
        opacity: _fade,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.black87, Colors.grey.shade800],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                      )
                    ],
                  ),
                  child: Center(
                    child: Image.asset("assets/logo.png")
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                "Trendora",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Luxury fashion, at your fingertips",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
