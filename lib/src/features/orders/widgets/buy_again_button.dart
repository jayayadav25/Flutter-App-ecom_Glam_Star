import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/cart_item_model.dart';
import '../../../core/models/order_model.dart';
import '../../cart/providers/cart_providers.dart';

class BuyAgainButton extends ConsumerWidget {
  final OrderModel order;

  const BuyAgainButton({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref,) {

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          padding:
          const EdgeInsets.symmetric(vertical: 16,),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16,),
          ),
        ),

        onPressed: () async {
          final cartNotifier = ref.read(cartProvider.notifier,);
          for (final item in order.items) {
            final cartItem = CartItemModel(
              productId: item['productId'],
              title: item['title'],
              image: item['image'],
              sellingPrice: (item['price'] as num).toDouble(),
              quantity: item['quantity'],
              // OPTIONAL
             actualPrice: (item['price'] as num).toDouble(),
              isSelected: true,
              updatedAt: DateTime.now(),
            );

            await cartNotifier.addToCart(cartItem,);
          }
          if (context.mounted) {
            ScaffoldMessenger.of(context,).showSnackBar(
              const SnackBar(
                content: Text('Items added to cart',),
              ),
            );
          }
        },

        child: const Text('Buy Again',),
      ),
    );
  }
}