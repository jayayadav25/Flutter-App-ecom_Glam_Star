import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/delivery_provider.dart';

class DeliveryEtaWidget extends ConsumerWidget {
  const DeliveryEtaWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eta = ref.watch(deliveryEtaProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_shipping_outlined),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eta.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Free delivery available',
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
