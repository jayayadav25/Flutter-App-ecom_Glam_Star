import 'package:firebase_mastery_app/src/common/styles/text_styles.dart';
import 'package:flutter/material.dart';
import '../../../core/models/address_model.dart';

class AddressDetailsScreen extends StatelessWidget {
  final AddressModel address;

  const AddressDetailsScreen({super.key, required this.address,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address Details",),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address.fullName,
                style: AppTextStyles.titleMedium,),
              const SizedBox(height: 14),
              Text(address.phone),
              const SizedBox(height: 14),
              Text(address.addressLine1,),
              Text(address.addressLine2 ?? ''),
              Text("${address.city}, ${address.state}",),
              Text(address.zipCode,),
            ],
          ),
        ),
      ),
    );
  }
}