import 'package:firebase_mastery_app/src/features/products/widgets/share_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/product_model.dart';
import '../../wishlist/provider/wishlist_providers.dart';

class LuxuryAppBar extends ConsumerWidget {
  final ProductModel product;

  const LuxuryAppBar({super.key, required this.product,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWishlisted = ref.watch(
      isWishlistedProvider(product.productId),
    );

    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      floating: true,
      leading: _button(
        icon: Icons.arrow_back_ios_new,
        onTap: () => context.pop(),
      ),
      actions: [
        _button(
          icon: isWishlisted
              ? Icons.favorite
              : Icons.favorite_border,
          iconColor:
          isWishlisted ? Colors.red : Colors.black,
          onTap: () async {
            // await ref
            //     .read(wishlistProvider.notifier)
            //     .toggleWishlist(
            //   WishlistItemModel(
            //     productId: product.productId,
            //     title: product.title,
            //     image: product.images.first.url,
            //     price:
            //     product.sellingPrice.toDouble(),
            //   ),
            // );
          },
        ),
        _button(
          icon: Icons.share_outlined,
          onTap: () {
            ShareService.shareProduct(
              title: product.title,
              price: product.sellingPrice,
            );
          },
        ),
      ],
    );
  }

  Widget _button({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: SizedBox(
            width: 44,
            height: 44,
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
