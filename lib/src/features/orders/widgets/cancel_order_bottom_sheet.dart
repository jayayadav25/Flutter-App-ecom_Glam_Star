import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cancel_order_provider.dart';

class CancelOrderBottomSheet extends ConsumerWidget {
  final String orderId;

  const CancelOrderBottomSheet({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    return Container(
      padding: const EdgeInsets.all(24,),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Cancel Order',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18,),
          const Text('Are you sure you want to cancel this order?',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30,),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {Navigator.pop(context,);
                  },
                  child: const Text('No',),
                ),
              ),
              const SizedBox(width: 12,),

              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () async {
                    await ref.read(cancelOrderProvider.notifier,).cancelOrder(orderId,);
                    if (context.mounted) {
                      Navigator.pop(context,);
                      ScaffoldMessenger.of(context,).showSnackBar(
                        const SnackBar(
                          content: Text('Order Cancelled',),
                        ),
                      );
                    }
                  },
                  child:
                  const Text('Yes Cancel',),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}