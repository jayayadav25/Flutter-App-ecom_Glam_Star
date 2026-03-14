import 'package:flutter/material.dart';
import '../../../core/models/address_model.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onChange;

  const AddressCard({
    super.key,
    required this.address,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(address.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text("${address.house}, ${address.city} - ${address.pincode}"),
          Text("Phone: ${address.phone}"),
          const SizedBox(height: 12),
          TextButton(
            onPressed: onChange,
            child: const Text("Change / Add Address"),
          )
        ],
      ),
    );
  }
}
