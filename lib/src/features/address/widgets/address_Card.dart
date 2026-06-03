import 'package:flutter/material.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import '../../../core/models/address_model.dart';

class AddressCard extends StatelessWidget {

  final AddressModel address;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  final VoidCallback onSetDefault;

  const AddressCard({
    super.key,
    required this.address,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: address.isDefault ? AppColors.primaryBlack : Colors.grey.shade300,
          ),

          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(0.04,),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Address Type
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlack,
                    borderRadius: BorderRadius.circular(30,),
                  ),
                  child: Text(address.addressType.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ),

                const Spacer(),
                if (address.isDefault)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6,),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(30,),
                    ),
                    child: Text("DEFAULT",
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),

           // const SizedBox(height: 2),

            Row(
              children: [
                Text(address.fullName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                ),
              ],
            ),
            Text(address.phone),
            Text(address.addressLine1),
            if (address.addressLine2.isNotEmpty)
              Text(address.addressLine2),
            Text("${address.city}, ${address.state}",),
            Text(address.zipCode),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onEdit,
                    child:Text("Edit",
                    style: AppTextStyles.productTitle,),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    onPressed: onSetDefault,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlack,
                    ),

                    child: Text(address.isDefault ? "Selected" : "Set Default",
                      style: const TextStyle(color: Colors.white,),
                    ),
                  ),
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }
}