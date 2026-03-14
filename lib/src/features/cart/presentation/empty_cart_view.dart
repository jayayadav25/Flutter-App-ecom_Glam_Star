import 'package:flutter/material.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            "Your cart is empty",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6),
          Text("Add items to start shopping"),
        ],
      ),
    );
  }
}
