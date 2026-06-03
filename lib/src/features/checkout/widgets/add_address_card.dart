import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/styles/text_styles.dart';

class AddAddressCard extends ConsumerWidget {
  final VoidCallback onTap;

  const AddAddressCard({super.key, required this.onTap,});

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),

        child: Row(
          children: [
            Icon(Icons.add_location_alt,),
            SizedBox(width: 14),
            Expanded(
              child: Text('Add Delivery Address',
                style:AppTextStyles.caption1
              ),
            ),

            Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}