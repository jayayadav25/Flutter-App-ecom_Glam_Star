import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/delivery_provider.dart';

class DeliveryEtaWidget extends ConsumerWidget {
  const DeliveryEtaWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eta = ref.watch(deliveryEtaProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 0.1),
      ),
      child: ListTile(
        leading: const Icon(Icons.local_shipping_outlined),
        title: Text(eta.label),
        subtitle: const Text("Free delivery on this order"),
      ),
    );
  }
}
