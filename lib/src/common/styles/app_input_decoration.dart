import 'package:flutter/material.dart';

class AppInputDecoration {

  static InputDecoration auth({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {

    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFF9E9E9E),
        fontSize: 15,
      ),

      prefixIcon: Icon(
        prefixIcon,
        color: const Color(0xFFD4AF37),
      ),

      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF8F7F4),

      contentPadding:
      const EdgeInsets.symmetric(
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
          width: 1.6,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.5,
        ),
      ),

      errorStyle: const TextStyle(
        color: Colors.redAccent,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}