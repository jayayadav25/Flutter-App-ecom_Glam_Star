import 'package:firebase_mastery_app/src/common/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/light_product_model.dart';
import '../../../core/models/wishlist_item_model.dart';
import '../../wishlist/provider/wishlist_providers.dart';

class LightProductCard extends ConsumerWidget {
  final LightProductModel product;
  const LightProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWishlisted = ref.watch(isWishlistedProvider(product.productId));
    final discountPercent = product.actualPrice > product.sellingPrice
        ? (((product.actualPrice - product.sellingPrice) / product.actualPrice) * 100).round() : 0;

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
              flex: 11,
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

                    //️ Wishlist
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () async {
                          await ref.read(wishlistProvider.notifier,).toggleWishlist(
                            item: WishlistItemModel(
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
                                : Icons.favorite_outline,
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
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

                    // Price Row
                    Row(
                      children: [
                        Text("₹${product.sellingPrice}",
                          style: AppTextStyles.productTitle
                        ),
                        const SizedBox(width: 6),
                        if (product.actualPrice >
                            product.sellingPrice)
                          Flexible(
                            child: Text(
                              "₹${product.actualPrice}",
                              style: AppTextStyles.oldPrice
                            ),
                          ),
                        SizedBox(width:10),
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

                    // Discount

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
