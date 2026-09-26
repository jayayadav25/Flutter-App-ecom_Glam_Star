import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecurePaymentBanner extends ConsumerWidget {
  const SecurePaymentBanner({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade400,
            Colors.green.shade600,
          ],
        ),

        borderRadius: BorderRadius.circular(15),
      ),

      child: const Row(
        children: [
          CircleAvatar(
            backgroundColor:
            Colors.white24,
            child: Icon(
              Icons.lock,
              color: Colors.white,
            ),
          ),

          SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '100% Secure Payments',

                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                    FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  'Encrypted & protected transactions',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
