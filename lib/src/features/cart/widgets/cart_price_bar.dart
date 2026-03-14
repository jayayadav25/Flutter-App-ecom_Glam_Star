import 'package:flutter/material.dart';

class CartPriceBar extends StatelessWidget {
  final double total;
  final VoidCallback onCheckout;

  const CartPriceBar({
    super.key,
    required this.total,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Total Amount",
                  style: TextStyle(color: Colors.grey)),
              Text(
                "₹$total",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            ),
            onPressed: onCheckout,
            child: const Text("Place Order"),
          ),
        ],
      ),
    );
  }
}
