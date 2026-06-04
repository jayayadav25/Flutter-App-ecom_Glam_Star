import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';

class OrderStatusCard extends ConsumerWidget {
  final String status;
  final DateTime date;

  const OrderStatusCard({
    super.key,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color statusColor;
    switch (status) {
      case 'Delivered':statusColor = AppColors.success;
        break;

      case 'Cancelled':statusColor = AppColors.error;
        break;

      case 'Shipped':statusColor = Colors.blue;
        break;

      default:statusColor = AppColors.softGold;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22,),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18,),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(status,
            style: AppTextStyles.heading1.copyWith(
              color: statusColor,
            ),
          ),
          const SizedBox(height: 10,),
          Text('On ${date.day} May as per your request.',
            style: AppTextStyles.bodyText1,),
        ],
      ),
    );
  }
}