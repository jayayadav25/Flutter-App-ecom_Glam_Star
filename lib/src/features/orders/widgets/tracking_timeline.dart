import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';

class TrackingTimeline extends ConsumerWidget {
  final String currentStatus;

  const TrackingTimeline({
    super.key,
    required this.currentStatus,
  });

  int get currentStep {
    switch (currentStatus) {
      case 'Placed':
        return 0;
      case 'Packed':
        return 1;
      case 'Shipped':
        return 2;
      case 'Out for Delivery':
        return 3;
      case 'Delivered':
        return 4;
      default:
        return 0;
    }
  }

  final List<Map<String, dynamic>>
  steps = const [

    {
      'title': 'Order Placed',
      'subtitle':
      'Your order has been confirmed',
      'icon': Icons.check_circle,
    },

    {
      'title': 'Packed',
      'subtitle':
      'Seller packed your order',
      'icon': Icons.inventory_2,
    },

    {
      'title': 'Shipped',
      'subtitle':
      'Your package is on the way',
      'icon': Icons.local_shipping,
    },

    {
      'title': 'Out for Delivery',
      'subtitle':
      'Delivery partner is nearby',
      'icon': Icons.delivery_dining,
    },

    {
      'title': 'Delivered',
      'subtitle':
      'Package delivered successfully',
      'icon': Icons.home,
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: List.generate(
        steps.length,
            (index) {
          final active = index <= currentStep;
          final item = steps[index];
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left
                Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300,),
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: active ? AppColors.primaryBlack : AppColors.grey300,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item['icon'],
                        color: Colors.white,
                        size: 20,
                      ),
                    ),

                    if (index != steps.length - 1)
                      Expanded(
                        child: Container(
                          width: 2,
                          margin: const EdgeInsets.symmetric(vertical: 6,),
                          color: active ? AppColors.primaryBlack : AppColors.grey300,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 18,),
                // Right
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 28,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: AppTextStyles.productTitle.copyWith(
                            color: active ? AppColors.primaryBlack : AppColors.grey500,
                          ),
                        ),

                        const SizedBox(height: 6,),
                        Text(item['subtitle'],
                          style: AppTextStyles.caption1.copyWith(
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}