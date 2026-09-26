import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final double amount;

  const PaymentButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : onPressed,
        child: isLoading
            ? const SizedBox(
          height: 22,
          width: 22,
          child:
          CircularProgressIndicator(),
        )
            : Text(
          'Pay ₹${amount.toStringAsFixed(2)}',
        ),
      ),
    );
  }
}