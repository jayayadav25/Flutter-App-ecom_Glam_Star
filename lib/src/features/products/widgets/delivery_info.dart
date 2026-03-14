import 'package:flutter/material.dart';

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Free Delivery by Tomorrow"),
        SizedBox(height: 4),
        Text("7 Days Easy Return"),
        SizedBox(height: 4),
        Text("Cash on Delivery Available"),
      ],
    );
  }
}
