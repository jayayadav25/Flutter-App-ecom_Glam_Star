import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';

class OfferCouponSection extends ConsumerWidget {
  const OfferCouponSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal:5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.cardColor,
            AppColors.cardColor,
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.local_offer_outlined,
                color: AppColors.softGold,
              ),
              SizedBox(width: 10),
              Text(
                'Exclusive Offers',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          _offer('10% Instant Discount on HDFC Cards'),
          _offer('Flat ₹500 OFF on orders above ₹2999'),
          _offer('No Cost EMI Available'),

        ],
      ),
    );
  }

  Widget _offer(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.softGold,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
