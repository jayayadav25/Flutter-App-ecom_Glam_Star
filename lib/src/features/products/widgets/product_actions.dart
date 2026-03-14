import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/models/product_model.dart';
import '../../wishlist/provider/wishlist_providers.dart';

class ProductActionsBar extends ConsumerWidget {
  final ProductModel product;

  const ProductActionsBar({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWishlisted =
    ref.watch(isWishlistedProvider(product.productId));

    return Positioned(
      top: 16,
      right: 16,
      child: Column(
        children: [
          _icon(
            icon: isWishlisted ? Icons.favorite : Icons.favorite_border,
            color: isWishlisted ? Colors.red : Colors.black,
            onTap: () {
              ref.read(wishlistProvider.notifier).toggle(product);
            },
          ),
          const SizedBox(height: 12),
          _icon(
            icon: Icons.share,
            color: Colors.black,
            onTap: () {
              Share.share(
                "${product.title}\n₹${product.sellingPrice}\nCheck this on Trendora!",
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _icon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        child: Icon(icon, color: color),
      ),
    );
  }
}
