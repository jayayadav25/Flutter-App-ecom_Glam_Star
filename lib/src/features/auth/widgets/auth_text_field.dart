// lib/src/features/auth/widgets/auth_text_field.dart

import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData prefixIcon;
  final Widget? suffix;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;

  const AuthTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.hint,
    required this.prefixIcon,
    this.suffix,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black87, width: 1.4),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
    );
  }
}
