import 'package:firebase_mastery_app/src/common/styles/app_button_styles.dart';
import 'package:firebase_mastery_app/src/common/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';
import '../../../core/models/address_model.dart';

class AddressSection extends ConsumerWidget {

  final AddressModel address;
  final VoidCallback onChange;

  const AddressSection({
    super.key,
    required this.address,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.whiteText,
                foregroundColor: AppColors.primaryBlack,
                child: Icon(Icons.location_on,
               ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  address.fullName,
                  style: AppTextStyles.smallTitle
                ),
              ),

              TextButton(
                style: AppButtonStyles.darkTextButton,
                onPressed: onChange,
                child: const Text('Change',),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            address.phone,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            '${address.addressLine1}, '
                '${address.city} - '
                '${address.zipCode}',
          ),
        ],
      ),
    );
  }
}
