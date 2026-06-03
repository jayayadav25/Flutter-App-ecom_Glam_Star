import 'package:flutter/material.dart';

class AuthTextField {

  static InputDecoration authInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,

      prefixIcon: Icon(
        prefixIcon,
        color: const Color(0xFFD4AF37),
      ),

      suffixIcon: suffixIcon,

      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 18,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: Color(0xFFD4AF37),
          width: 1.5,
        ),
      ),
    );
  }
}