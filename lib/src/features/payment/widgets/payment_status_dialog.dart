import 'package:flutter/material.dart';

class PaymentStatusDialog {
  static Future<void> showSuccess(
      BuildContext context, {
        required String orderId,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Payment Successful',
          ),
          content: Text(
            'Order ID: $orderId',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showFailure(
      BuildContext context, {
        required String message,
      }) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Payment Failed',
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Retry',
              ),
            ),
          ],
        );
      },
    );
  }
}