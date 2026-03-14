import 'package:flutter/material.dart';

class PriceRow extends StatelessWidget {
  final String label;
  final double value;
  final bool bold;
  final bool strike;
  final Color valueColor;

  const PriceRow({
    super.key,
    required this.label,
    required this.value,
    this.bold = false,
    this.strike = false,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            "₹${value.abs().toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
              color: valueColor,
              decoration: strike ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }
}
