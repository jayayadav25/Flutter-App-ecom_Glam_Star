import 'package:flutter/material.dart';

class PremiumBadge extends StatelessWidget {
  const PremiumBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Text(
        "PREMIUM MEMBER",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}