import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/address_provider.dart';

class AddressCard extends ConsumerWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final address = ref.watch(selectedAddressProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 0.2),
      ),
      child: ListTile(
        leading: const Icon(Icons.location_on_outlined),
        title: Text(address?.name ?? ''),
        subtitle: Text(address?.addressLine ?? ''),
        trailing: TextButton(
          child: const Text("CHANGE"),
          onPressed: () {
            ref.read(selectedAddressProvider.notifier).change(
              Address(
                "Office",
                "Electronic City, Bangalore",
              ),
            );
          },
        ),
      ),
    );
  }
}
