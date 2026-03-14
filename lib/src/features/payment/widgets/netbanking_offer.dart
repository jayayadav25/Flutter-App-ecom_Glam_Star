import 'package:flutter/material.dart';
import '../../../../widgets/app_Button.dart';

class NetBankingSection extends StatelessWidget {
  final double finalAmount;
  final ValueChanged<String> onPay;

  const NetBankingSection({
    super.key,
    required this.finalAmount,
    required this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    final banks = ["HDFC", "SBI", "ICICI", "AXIS", "Other Bank"];
    String selectedBank = banks.first;

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            ...banks.map(
                  (b) => RadioListTile<String>(
                value: b,
                groupValue: selectedBank,
                activeColor: Colors.black,
                title: Text(
                  b,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                onChanged: (v) {
                  setState(() => selectedBank = v!);
                },
              ),
            ),

            const SizedBox(height: 12),

            // Pay button
            AppButton(
              text: "Pay ₹${finalAmount.toStringAsFixed(0)}",
              onPressed: () {
                onPay(selectedBank);
              },
            ),
          ],
        );
      },
    );
  }
}
