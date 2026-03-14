import 'package:flutter/material.dart';

class OrderItemTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String deliveryText;

  const OrderItemTile({
    super.key,
    required this.title,
    required this.imageUrl,
    this.deliveryText = "Delivery by Tomorrow",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 60,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  deliveryText,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
