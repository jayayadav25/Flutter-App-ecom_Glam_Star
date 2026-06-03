import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/order_model.dart';
import '../../cart/providers/cart_providers.dart';
import '../providers/reorder_provider.dart';

class OrderActionButtons extends ConsumerWidget {
  final OrderModel order;

  const OrderActionButtons({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    return Row(
      children: [
        // TRACK
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15,),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16,),
              ),
            ),

            onPressed: () {
              context.push('/tracking',
                extra: order,
              );
            },

            child: const Text(
              'Track Order',
            ),
          ),
        ),

        const SizedBox(width: 12),
        // BUY AGAIN
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15,),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16,),
              ),
            ),

            onPressed: () async {
              final cartNotifier = ref.read(cartProvider.notifier,);
              await ref.read(reorderUsecaseProvider,).reorder(
                order: order,
                cartNotifier: cartNotifier,
              );
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
        ),
      ],
    );
  }
}