import 'package:flutter/material.dart';
import '../../../common/styles/colors.dart';

class RatingSection extends StatelessWidget {
  final double rating;

  const RatingSection({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: AppColors.success,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Text(
                rating.toStringAsFixed(1),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.star,
                color: Colors.white,
                size: 16,
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        const Text(
          '12.5k Verified Ratings',
          style: TextStyle(
            color: AppColors.grey700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
