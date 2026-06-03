import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/images.dart';

class AddressEmptyState extends ConsumerWidget {

  final VoidCallback onAdd;

  const AddressEmptyState({
    super.key,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.add_address,
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 20),
          const Text("No Saved Addresses",
            style: TextStyle(
              fontSize: 22,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),
          const Text("Add an address for faster checkout",),
          const SizedBox(height: 24),
          // ElevatedButton(
          //   onPressed: onAdd,
          //   child: const Text(
          //     "Add Address",
          //   ),
          // ),
        ],
      ),
    );
  }
}