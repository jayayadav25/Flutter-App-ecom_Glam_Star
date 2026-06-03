import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileInputField extends ConsumerWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextInputType? keyboardType;

  const ProfileInputField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}