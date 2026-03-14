import 'package:flutter/material.dart';

class PriceDetailsSection extends StatelessWidget {
  final double total;

  const PriceDetailsSection({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text("Price Details"),
      children: [
        ListTile(
          title: const Text("Order Total"),
          trailing: Text(
            "₹$total",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
