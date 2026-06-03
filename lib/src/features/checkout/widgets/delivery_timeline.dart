import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';

class DeliveryTimeline extends ConsumerWidget {
  final String deliveryDate;

  const DeliveryTimeline({super.key, required this.deliveryDate,});

  @override
  Widget build(BuildContext context,  WidgetRef ref,) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
        BoxShadow(
        color: Colors.black12,
        blurRadius: 18,
        offset: const Offset(0, 8),
        ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.whiteText,
            foregroundColor: AppColors.primaryBlack,
            child: Icon(Icons.local_shipping,),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Estimated Delivery',
                  style: AppTextStyles.smallTitle
                ),

                const SizedBox(height: 6),

                Text(
                  deliveryDate,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}