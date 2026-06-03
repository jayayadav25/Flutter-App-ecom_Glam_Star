import 'package:flutter/material.dart';

class WishlistEmptyView
    extends StatelessWidget {

  const WishlistEmptyView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [

          Icon(
            Icons.favorite_border,
            size: 90,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 20),

          const Text(
            'Your wishlist is empty',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'Save your favorite fashion items',
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}