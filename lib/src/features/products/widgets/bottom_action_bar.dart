import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../common/styles/colors.dart';
import '../../../core/models/cart_item_model.dart';
import '../../../core/models/product_model.dart';
import '../../cart/providers/cart_providers.dart';
import '../providers/size_provider.dart';

class LuxuryBottomBar extends ConsumerWidget {
  final ProductModel product;

  const LuxuryBottomBar({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final selectedSize = ref.watch(selectedSizeProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final isAlreadyInCart = ref.watch(cartProvider,)
        .value?.any(
              (e) => e.productId ==
              product.productId.toString(),
        ) ?? false;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Add to cart
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 58),
                  side: const BorderSide(
                    color: AppColors.primaryBlack,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                onPressed: () async {
                  // Size Validation
                  if (selectedSize == null) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please select a size',
                        ),
                      ),
                    );

                    return;
                  }

                  // If already in cart
                  if (isAlreadyInCart) {context.push('/cart');
                    return;
                  }

                  // ADD PRODUCT
                  await cartNotifier.addToCart(
                    CartItemModel(
                      productId: product.productId.toString(),
                      title: product.title,
                      image: product.images.first.url,
                      sellingPrice: product.sellingPrice.toDouble(),
                      actualPrice: product.actualPrice.toDouble(),
                      quantity: 1,
                      isSelected: true,
                      updatedAt: DateTime.now(),
                    ),
                  );

                  if (context.mounted) {

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 2),
                        content: Text(
                          '${product.title} added to cart',
                        ),
                      ),
                    );
                  }
                },

                child: Text(
                  isAlreadyInCart
                      ? 'Go To Cart'
                      : 'Add To Cart',
                  style: const TextStyle(
                    color: AppColors.primaryBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Buy now
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  AppColors.primaryBlack,
                  foregroundColor:
                  Colors.white,
                  minimumSize: const Size(double.infinity, 58),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () async {
                  // Size validation
                  if (selectedSize == null) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please select a size',
                        ),
                      ),
                    );

                    return;
                  }

                  // Add to cart if not exists
                  if (!isAlreadyInCart) {
                    await cartNotifier.addToCart(
                      CartItemModel(
                        productId: product.productId.toString(),
                        title: product.title,
                        image: product.images.first.url,
                        sellingPrice: product.sellingPrice.toDouble(),
                        actualPrice: product.actualPrice.toDouble(),
                        quantity: 1,
                        isSelected: true,
                        updatedAt: DateTime.now(),
                      ),
                    );
                  }

                  if (context.mounted) {
                    // Buy now
                    context.push('/checkout');
                  }
                },
                child: const Text('Buy Now',
                  style: TextStyle(fontWeight: FontWeight.bold,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}