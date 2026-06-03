import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppliedCouponCard extends ConsumerWidget {

  final String code;
  final VoidCallback onRemove;

  const AppliedCouponCard({
    super.key,
    required this.code,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius:
        BorderRadius.circular(15),
      ),

      child: Row(
        children: [
          const Icon(Icons.discount,
            color: Colors.green,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              '$code Applied',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.close,),
          ),
        ],
      ),
    );
  }
}