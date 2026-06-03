import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/text_styles.dart';
import '../../../core/models/order_model.dart';
import '../widgets/deliver_status_badge.dart';
import '../widgets/tracking_timeline.dart';

class TrackingScreen extends ConsumerWidget {

  final OrderModel order;

  const TrackingScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Track Order',),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16,),
        child: Column(
          children: [
            // HEADER CARD
            Container(
              padding: const EdgeInsets.all(22,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28,),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04,),
                    blurRadius: 20,
                    offset: const Offset(0, 10,),),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.local_shipping,
                    size: 60,
                  ),
                  const SizedBox(height: 16,),
                  Text('Order #${order.id.substring(0, 6)}',
                    style: AppTextStyles.heading2,),
                  const SizedBox(height: 12,),
                  DeliveryStatusBadge(status: order.deliveryStatus,),
                  const SizedBox(height: 18,),
                  Text('Estimated Delivery',
                    style: AppTextStyles.caption1,),

                  const SizedBox(height: 6,),
                  Text('Tomorrow, 7 PM',
                    style: AppTextStyles.productTitle,),
                ],
              ),
            ),
            const SizedBox(height: 20,),

            // TIMELINE
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28,),
              ),
              child: TrackingTimeline(
                currentStatus: order.deliveryStatus,
              ),
            ),
            const SizedBox(height: 20,),

            // SHIPPING ADDRESS
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28,),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Shipping Address',
                    style: AppTextStyles.sectionTitle,),
                  const SizedBox(height: 16,),
                  Text(order.address['name'] ?? '',),
                  const SizedBox(height: 6,),
                  Text(order.address['phone'] ?? '',),
                  const SizedBox(height: 6,),
                  Text(order.address['addressLine1'] ?? '',),
                  const SizedBox(height: 6,),
                  Text('${order.address['city']} - ${order.address['zipCode']}',),
                ],
              ),
            ),

            const SizedBox(height: 30,),

            // SUPPORT BUTTONS
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18,),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.support_agent,
                    ),

                    label: const Text('Support',),
                  ),
                ),

                const SizedBox(width: 14,),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18,),
                      ),
                    ),

                    onPressed: () {},
                    icon: const Icon(
                      Icons.receipt_long,
                    ),
                    label: const Text('Invoice',),
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