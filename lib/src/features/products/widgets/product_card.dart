import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/product_model.dart';
import '../../wishlist/provider/wishlist_providers.dart';

class ProductCard extends ConsumerWidget {
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWishlisted = ref.watch(isWishlistedProvider(product.productId));

    final imageUrl = product.images.isNotEmpty ? product.images.first : null;

    return GestureDetector(
      onTap: () {
        context.push('/product-detail/${product.productId}');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: imageUrl != null
                      ? ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                    child: Image.network(
                      imageUrl.url,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image),
                    ),
                  )
                      : const Center(child: Icon(Icons.image)),
                ),

                // Wishlist icon
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      ref
                          .read(wishlistProvider.notifier)
                          .toggle(product);
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(
                        isWishlisted
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                        isWishlisted ? Colors.red : Colors.black,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Product info
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹${product.sellingPrice}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
