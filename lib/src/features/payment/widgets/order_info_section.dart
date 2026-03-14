import 'package:flutter/material.dart';

class OrderInfoSection extends StatelessWidget {
  final String name;
  final String address;
  final String phone;

  const OrderInfoSection({
    super.key,
    required this.name,
    required this.address,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text("Deliver To"),
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(address),
              Text("Phone: $phone"),
            ],
          ),
        ),
      ],
    );
  }
}
