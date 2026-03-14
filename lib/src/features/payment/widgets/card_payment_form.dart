import 'package:flutter/material.dart';
import '../../../../widgets/app_Button.dart';

class CardPaymentForm extends StatelessWidget {
  final double finalAmount;
  final VoidCallback onPay;

  const CardPaymentForm({
    super.key,
    required this.finalAmount,
    required this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(
          decoration: InputDecoration(labelText: "Card Number"),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: "MM/YY"),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: "CVV"),
                obscureText: true,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Pay button
        AppButton(
          text: "Pay ₹${finalAmount.toStringAsFixed(0)}",
          onPressed: onPay,
        ),
      ],
    );
  }
}
