import 'package:firebase_mastery_app/src/features/orders/widgets/tracking_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import '../../../core/models/order_model.dart';

class TrackingScreen extends ConsumerWidget {

  final OrderModel order;

  const TrackingScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        title: const Text('Track Order',),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16,),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20,
                ),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.local_shipping,
                    size: 70,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(order.deliveryStatus,
                    style: AppTextStyles.heading1,
                  ),
                  const SizedBox(height: 10,),
                  Text('Estimated Delivery Tomorrow',),
                ],
              ),
            ),

            const SizedBox(height: 22,),

            // Timeline
            Expanded(
              child: Container(
                width: double.infinity,

                padding:
                const EdgeInsets.all(
                  24,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(
                    20,
                  ),
                ),

                child: TrackingTimeline(
                  currentStatus:
                  order
                      .deliveryStatus,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}