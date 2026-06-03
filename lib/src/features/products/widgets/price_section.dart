import 'package:flutter/material.dart';
import '../../../common/styles/colors.dart';

class PriceSection extends StatelessWidget {
  final double price;
  final double mrp;
  final int discount;

  const PriceSection({
    super.key,
    required this.price,
    required this.mrp,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '₹${price.toInt()}',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlack,
          ),
        ),

        const SizedBox(width: 12),

        Text(
          '₹${mrp.toInt()}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),
        ),

        const SizedBox(width: 10),

        Text(
          '$discount% OFF',
          style: const TextStyle(
            color: AppColors.success,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}