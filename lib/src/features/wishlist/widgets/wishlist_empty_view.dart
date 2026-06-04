import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/images.dart';

class WishlistEmptyView extends ConsumerWidget {
  const WishlistEmptyView({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon(
          //   Icons.favorite_border,
          //   size: 90,
          //   color: Colors.grey.shade400,
          // ),
          Image.asset(
            AppImages.empty_wishlist,
            width: 325,
            height: 325,
            fit: BoxFit.cover,
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

          Center(
            child: Text(
              "Save products you love and build your dream collection.",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}