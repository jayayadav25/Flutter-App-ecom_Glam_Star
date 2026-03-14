import 'package:flutter/material.dart';
import '../../../../widgets/app_Button.dart';

enum UpiOption { paytm, other }

class UpiPaymentSection extends StatefulWidget {
  final double finalAmount;
  final Future<void> Function(String method, String? upiId) onPay;

  const UpiPaymentSection({
    super.key,
    required this.finalAmount,
    required this.onPay,
  });

  @override
  State<UpiPaymentSection> createState() => _UpiPaymentSectionState();
}

class _UpiPaymentSectionState extends State<UpiPaymentSection> {
  UpiOption selected = UpiOption.paytm;
  final TextEditingController upiController = TextEditingController();

  @override
  void dispose() {
    upiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Paytm
        _radioTile(
          title: "Paytm",
          subtitle: "Pay using Paytm UPI",
          value: UpiOption.paytm,
        ),

        // other UPI
        _radioTile(
          title: "Other UPI",
          subtitle: "Google Pay, PhonePe, BHIM",
          value: UpiOption.other,
        ),

        // UPI field
        if (selected == UpiOption.other) ...[
          const SizedBox(height: 12),
          TextField(
            controller: upiController,
            decoration: InputDecoration(
              hintText: "Enter UPI / VPA (eg: name@upi)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],

        const SizedBox(height: 16),

        // Pay button
        AppButton(
          text: "Pay ₹${widget.finalAmount.toStringAsFixed(0)}",
          onPressed: () async {
            if (selected == UpiOption.other &&
                upiController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please enter UPI ID")),
              );
              return;
            }

            await widget.onPay(
              selected == UpiOption.paytm ? "Paytm UPI" : "Other UPI",
              selected == UpiOption.other
                  ? upiController.text.trim()
                  : null,
            );
          },
        ),
      ],
    );
  }

  Widget _radioTile({
    required String title,
    required String subtitle,
    required UpiOption value,
  }) {
    return RadioListTile<UpiOption>(
      value: value,
      groupValue: selected,
      activeColor: Colors.black,
      contentPadding: EdgeInsets.zero,
      onChanged: (v) => setState(() => selected = v!),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle),
    );
  }
}
