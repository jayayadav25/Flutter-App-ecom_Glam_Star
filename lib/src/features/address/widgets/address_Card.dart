import 'package:flutter/material.dart';
import '../../../core/models/address_model.dart';

class AddressCard extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;
  final bool isSelected;

  const AddressCard({
    super.key,
    required this.address,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFEDEDED)
              : const Color(0xFFFFFEFC),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? Colors.grey.shade500
                : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Header
           Row(
             children: [
               CircleAvatar(
                 radius: 24,
                 backgroundColor: Colors.white,
                 child: Icon(
                   _icon,
                   color: Colors.black87,
                 ),
               ),
               const SizedBox(width: 12),

               Expanded(
                 child: Column(
                   crossAxisAlignment:
                   CrossAxisAlignment.start,
                   children: [
                     Text(
                       address.fullName,
                       style: const TextStyle(
                         fontSize: 17,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     Text(
                       address.addressType.toUpperCase(),
                       style: TextStyle(
                         fontSize: 10,
                         letterSpacing: 1,
                         color: Colors.grey.shade600,
                       ),
                     ),
                   ],
                 ),
               ),
               // Select
                Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? Colors.black87
                        : Colors.transparent,
                    border: Border.all(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                    Icons.check,
                    size: 17,
                    color: Colors.white,
                  )
                      : null,
                ),
             ],
           ),

            const SizedBox(height: 18),
            // Address
            Text(
              _address,
              style: TextStyle(
                height: 1.5,
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              address.phone,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 15),

              // Status + Actions
            Row(
              children: [
                if (isSelected)
                  _badge(
                    '✓ Delivering here',
                    Colors.green,
                  ),

                if (address.isDefault && !isSelected)
                  _badge(
                    'DEFAULT',
                    Colors.green,
                  ),

                const Spacer(),

                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 19,
                  ),
                ),

                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 19,
                  ),
                ),
              ],
            ),

            if (!address.isDefault)
              SizedBox(
                width: double.infinity,
                height: 38,
                child: OutlinedButton(
                  onPressed: onSetDefault,
                  child: const Text(
                    'Set as Default',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String get _address =>
      [
        address.addressLine1,
        if (address.addressLine2.isNotEmpty)
          address.addressLine2,
        '${address.city}, ${address.state}',
        address.zipCode,].join(', ');

  IconData get _icon {
    switch (address.addressType.toLowerCase()) {
      case 'home':
        return Icons.home_outlined;
        case 'office':
          case 'work':
            return Icons.business_outlined;
            default:
              return Icons.location_on_outlined;

    }
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
