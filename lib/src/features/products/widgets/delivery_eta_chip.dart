import 'package:flutter/material.dart';

class DeliveryEtaChip extends StatelessWidget {
  final String text;

  const DeliveryEtaChip({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [
          const Icon(
            Icons.local_shipping_outlined,
            color: Colors.green,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}