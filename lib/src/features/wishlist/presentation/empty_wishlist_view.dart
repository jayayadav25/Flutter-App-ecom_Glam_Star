import 'package:flutter/material.dart';

class EmptyWishlistView extends StatelessWidget {
  const EmptyWishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.favorite_border, size: 90, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            "Your wishlist is empty",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text("Save items you love "),
        ],
      ),
    );
  }
}
