import 'package:firebase_mastery_app/src/common/styles/app_button_styles.dart';
import 'package:firebase_mastery_app/src/common/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/cart_final_provider.dart';
import '../providers/cart_providers.dart';
import '../widgets/cart_item_card.dart';
import 'empty_cart_view.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartProvider);
    final total = ref.watch(finalAmountProvider);

    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      body: cartAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: EmptyCartView(),
            );
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, index) {
              return PremiumCartItemCard(
                item: items[index],
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, _) => Center(
          child: Text(e.toString()),
        ),
      ),

      bottomNavigationBar: cartAsync.when(
        data: (items) {
          // HIDE IF EMPTY
          if (items.isEmpty) {
            return const SizedBox.shrink();
          }
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  // TOTAL
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Total Amount',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('₹${total.toStringAsFixed(0)}',
                          style: AppTextStyles.productTitle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  // CHECKOUT BUTTON
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: AppButtonStyles.buyNowButton,
                        onPressed: () {context.push('/checkout');},
                        child: const Text('Proceed To Buy',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },

        loading: () => null,

        error: (_, __) => null,
      ),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.all(10),
      //   decoration: const BoxDecoration(
      //     color: Colors.white,
      //   ),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             const Text('Total Amount'),
      //             Text(
      //               '₹${total.toStringAsFixed(0)}',
      //               style: AppTextStyles.productTitle
      //             ),
      //           ],
      //         ),
      //       ),
      //       Expanded(
      //         child: SizedBox(
      //           height: 40,
      //           child: ElevatedButton(
      //             style: AppButtonStyles.buyNowButton,
      //             // ElevatedButton.styleFrom(
      //             //   backgroundColor: AppColors.softGold,
      //             //   shape: RoundedRectangleBorder(
      //             //     borderRadius: BorderRadius.circular(16),
      //             //   ),
      //             // ),
      //             onPressed: () {},
      //             child: const Text(
      //               'Buy Now',
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
