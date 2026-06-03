import 'package:firebase_mastery_app/src/common/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/styles/colors.dart';

class PaymentOffersCard extends ConsumerWidget {
  final VoidCallback onViewAll;

  const PaymentOffersCard({super.key, required this.onViewAll,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF4),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color:AppColors.softGold,
        ),
      ),

      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.softGold.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_offer,
              color:AppColors.softGold,
            ),
          ),

          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Payment Offers',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 4),
                Text('View all bank & wallet offers',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          TextButton(
            onPressed: onViewAll,
            child: Text(
              'View All',
              style: AppTextStyles.goldButtonText,
            ),
          ),
        ],
      ),
    );
  }
}