import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import '../../../core/models/order_model.dart';
import '../widgets/buy_again_button.dart';
import '../widgets/delivery_address_card.dart';
import '../widgets/invoice_section.dart';
import '../widgets/order_price_breakdown.dart';
import '../widgets/order_product_tile.dart';
import '../widgets/order_status_card.dart';
import '../widgets/return_order_button.dart';
import '../widgets/support_section.dart';
import '../widgets/tracking_timeline.dart';

class OrderDetailsScreen extends ConsumerWidget {
  final OrderModel order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Order Details',
              style: AppTextStyles.heading2,
            ),
            const SizedBox(height: 2),
            Text('Order ID: ${order.id}',
              style: AppTextStyles.caption1,
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PRODUCTS
            ...order.items.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16,),
                  child: OrderProductTile(
                    item: item,
                  ),
                );
              },
            ),

            // STATUS
            OrderStatusCard(
              status: order.deliveryStatus,
              date: order.createdAt,
            ),
            const SizedBox(height: 24),
            // TIMELINE
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tracking Timeline',
                    style: AppTextStyles.heading2,),
                  const SizedBox(height: 28),
                  TrackingTimeline(
                    currentStatus: order.deliveryStatus,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ADDRESS
            DeliveryAddressCard(order: order,),
            const SizedBox(height: 24),
            // PRICE BREAKDOWN
            OrderPriceBreakdown(order: order,),

            const SizedBox(height: 24),
            // INVOICE
            InvoiceSection(order: order,),
            const SizedBox(height: 18),
            // RETURN BUTTON
            if (order.deliveryStatus == 'Delivered')
              const ReturnOrderButton(),
            if (order.deliveryStatus == 'Delivered')
              const SizedBox(height: 18),
            // BUY AGAIN
            BuyAgainButton(order: order,),
            const SizedBox(height: 18),
            // SUPPORT
            const SupportSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
