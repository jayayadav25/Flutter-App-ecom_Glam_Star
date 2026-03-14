import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscure;
  final TextInputType keyboardType;


  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.black87),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}