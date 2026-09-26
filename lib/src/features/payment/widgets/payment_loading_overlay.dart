import 'package:flutter/material.dart';

class PaymentLoadingOverlay extends StatelessWidget {
  const PaymentLoadingOverlay({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
      Colors.black.withOpacity(0.4),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}