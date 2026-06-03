import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';

class DeliveryStatusBadge extends ConsumerWidget {
  final String status;

  const DeliveryStatusBadge({
    super.key,
    required this.status,
  });

  Color get statusColor {
    switch (status) {
      case 'Delivered':
        return AppColors.success;
      case 'Cancelled':
        return AppColors.error;
      case 'Shipped':
        return Colors.blue;
      default:
        return AppColors.softGold;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7,),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.12,),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(status,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}