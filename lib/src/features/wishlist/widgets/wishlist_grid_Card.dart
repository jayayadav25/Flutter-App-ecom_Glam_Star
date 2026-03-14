import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/product_model.dart';
import '../provider/wishlist_providers.dart';

class WishlistGridCard extends ConsumerWidget {
  final ProductModel product;

  const WishlistGridCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.read(wishlistProvider.notifier);
    final imageUrl =
    product.images.isNotEmpty ? product.images.first.url : null;

    final hasDiscount = product.actualPrice > product.sellingPrice;

    return Dismissible(
      key: ValueKey(product.productId),
      direction: DismissDirection.endToStart,
      background: _deleteBg(),
      onDismissed: (_) {
        wishlist.remove(product.productId.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Removed from wishlist")),
        );
      },
      child: GestureDetector(
        onTap: () {
          context.push('/product/${product.productId}');
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
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
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(14),
                      ),
                      child: imageUrl != null
                          ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image),
                      )
                          : const Icon(Icons.image_not_supported),
                    ),
                  ),

                  //  Wishlist icon
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        wishlist.remove(product.productId.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Removed from wishlist"),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12, blurRadius: 4),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    ),
                  ),

                  //  Discount badge
                  if (hasDiscount)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "${product.discount}% OFF",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              // Text content
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "₹${product.sellingPrice}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _deleteBg() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.red.shade400,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }
}
