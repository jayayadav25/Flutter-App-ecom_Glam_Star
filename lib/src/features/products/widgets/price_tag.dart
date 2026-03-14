import 'package:flutter/material.dart';

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
      children: [
        Text(
          "₹$price",
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        const SizedBox(width: 12),
        if (discount > 0)
          Text(
            "₹$mrp",
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
        const SizedBox(width: 8),
        if (discount > 0)
          Text(
            "$discount% OFF",
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}
