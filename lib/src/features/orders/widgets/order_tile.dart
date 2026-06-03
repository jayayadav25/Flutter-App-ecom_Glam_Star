import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import '../../../core/models/order_model.dart';
import '../providers/order_expansion_provider.dart';
import 'deliver_status_badge.dart';
import 'order_action_button.dart';
import 'order_item_card.dart';

class OrderTile extends ConsumerWidget {
  final OrderModel order;

  const OrderTile({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final expandedOrder = ref.watch(expandedOrderProvider,);
    final isExpanded = expandedOrder == order.id;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300,),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05,),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        children: [
          // Header
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              ref.read(expandedOrderProvider.notifier,)
                  .state = isExpanded ? null : order.id;
            },
            child: Padding(
              padding: const EdgeInsets.all(15,),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15,),
                    child: CachedNetworkImage(
                      imageUrl: order.items.first['image'],
                      width: 78,
                      height: 96,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 16,),
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Order id
                        Text(
                          'Order #${order.id.substring(0, 8)}',
                          style: AppTextStyles.productTitle,),
                        const SizedBox(height: 8,),
                        // Item count
                        Text('${order.items.length} items',
                          style: AppTextStyles.caption1,),

                        const SizedBox(height: 12,),
                        // Status
                        DeliveryStatusBadge(status: order.deliveryStatus,),
                        const SizedBox(height: 12,),
                        // Date
                        Text('Placed on ${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}',
                          style: AppTextStyles.caption1,),
                      ],
                    ),
                  ),

                  // RIGHT SECTION
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // PRICE
                      Text('₹${order.totalAmount.toStringAsFixed(0)}',
                        style: AppTextStyles.titleMedium,),
                      const SizedBox(height: 14,),
                      AnimatedRotation(
                        duration: const Duration(milliseconds: 300,),
                        turns: isExpanded ? 0.5 : 0,
                        child: const Icon(Icons.keyboard_arrow_down,),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // EXPANDED SECTION
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300,),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: const SizedBox(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(10,0, 10, 10,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 16,),
                  // ITEMS
                  ...order.items.map((item) {
                      return OrderItemCard(item: item,);
                    },
                  ),
                  const SizedBox(height: 8,),
                  // ADDRESS
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16,),
                    decoration: BoxDecoration(
                      color: AppColors.grey50,
                      borderRadius: BorderRadius.circular(20,),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Delivery Address',
                          style: AppTextStyles.sectionTitle,
                        ),
                        const SizedBox(height: 12,),
                        Text(order.address['name'] ?? '',),
                        const SizedBox(height: 6,),
                        Text(order.address['phone'] ?? '',),
                        const SizedBox(height: 6,),
                        Text(order.address['addressLine1'] ?? '',),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  // ACTION BUTTONS
                  OrderActionButtons(order: order,),
                  const SizedBox(height: 14,),

                  // DETAILS BUTTON
                  SizedBox(width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16,),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18,),
                        ),
                      ),

                      onPressed: () {
                        context.push('/order-details', extra: order,);
                      },
                      child: const Text(
                        'View Full Details',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
