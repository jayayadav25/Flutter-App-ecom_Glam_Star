import 'package:flutter/material.dart';

class CheckoutTheme {
  static const background = Color(0xFFF7F7F7);
  static const primary = Colors.black;
  static BoxDecoration luxuryCard =
  BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 20,
        offset: Offset(0, 8),
      ),
    ],
  );
}