import 'package:flutter/material.dart';
import '../../../common/styles/app_input_decoration.dart';

class AuthField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: AppInputDecoration.auth(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

