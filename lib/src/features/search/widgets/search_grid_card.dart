import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../common/styles/text_styles.dart';
import '../../../core/models/light_product_model.dart';
import '../../../core/models/wishlist_item_model.dart';
import '../../wishlist/provider/wishlist_providers.dart';

class SearchGridCard extends ConsumerWidget {
  final LightProductModel product;

  const SearchGridCard({required this.product});

  @override
  Widget build(BuildContext context,  WidgetRef ref) {
    final isWishlisted = ref.watch(isWishlistedProvider(product.productId));
    final discountPercent = product.actualPrice > product.sellingPrice
        ? (((product.actualPrice - product.sellingPrice) /
        product.actualPrice) * 100).round() : 0;

    return GestureDetector(
      onTap: () {
        context.push('/product/${product.productId}');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 12,
              child: Container(
                color:Colors.white,
                child: Stack(
                  children: [
                    Image.network(
                      product.thumbnail,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      errorBuilder: (_, __, ___) =>
                      const Center(child: Icon(Icons.image_not_supported)),
                    ),

                    // Wishlist
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () async {
                          await ref.read(wishlistProvider.notifier,)
                              .toggleWishlist(item: WishlistItemModel(
                              productId: product.productId,
                              title: product.title,
                              image: product.thumbnail.toString(),
                              sellingPrice: product.sellingPrice.toDouble(),
                              actualPrice: product.actualPrice.toDouble(),
                              discount: product.discount,
                              rating: product.averageRating.toDouble(),
                              addedAt: DateTime.now(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(6),
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
              ),
            ),

            // Details
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text("GlamStar",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.productBrand

                    ),
                    Text(product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.productTitle
                    ),
                    const Spacer(),

                    // Price Row
                    Row(
                      children: [
                        Text("₹${product.sellingPrice}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (product.actualPrice >
                            product.sellingPrice)
                          Text("₹${product.actualPrice}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration:
                              TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),

                    // discount
                    if (discountPercent > 0)
                      Text(
                        "$discountPercent% OFF",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}