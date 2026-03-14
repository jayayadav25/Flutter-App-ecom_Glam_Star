import 'package:flutter/material.dart';

class RatingSection extends StatelessWidget {
  final double rating;
  const RatingSection({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.orange, size: 18),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 6),
        const Text("(1.2k ratings)", style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
