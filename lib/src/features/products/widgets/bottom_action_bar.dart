import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomActionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                print("add to cart");
                context.push("/cart");
              },
              child: const Text("Add to Cart"),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () {},
              child: const Text("Buy Now"),
            ),
          ),
        ],
      ),
    );
  }
}
