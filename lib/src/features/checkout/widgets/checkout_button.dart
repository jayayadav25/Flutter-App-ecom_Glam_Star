import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutButton extends ConsumerWidget {
  final VoidCallback onTap;
  final String title;
  final bool loading;

  const CheckoutButton({
    super.key,
    required this.onTap,
    required this.title,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: loading ? null : onTap,
        child: loading ? const CircularProgressIndicator(color: Colors.white,) : Text(title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
