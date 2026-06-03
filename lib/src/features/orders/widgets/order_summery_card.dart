import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import '../../../core/models/order_model.dart';

class OrderSummaryCard extends StatelessWidget {
  final OrderModel order;

  const OrderSummaryCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final item = order.items.first;
    final address = order.address;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.borderColor,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOP
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Order ID',
                      style: AppTextStyles.caption1,),
                    const SizedBox(height: 4,),
                    Text(order.id,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.productTitle,
                    ),
                  ],
                ),
              ),

              Text('${order.createdAt.day} '
                  '${_month(order.createdAt.month)}',
                style: AppTextStyles.bodyText1,
              ),
            ],
          ),

          const SizedBox(height: 10),

          // STATUS
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(order.deliveryStatus,
                  style: AppTextStyles.heading2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Text('${order.totalItems} items • '
                '${address['city'] ?? ''}',
            style: AppTextStyles.bodyText1,
          ),

          const SizedBox(height: 5),

          // PRODUCT
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.borderColor,
              ),
              borderRadius: BorderRadius.circular(14),
            ),

            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: item['image'],
                    width: 70,
                    height: 85,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.productTitle,
                      ),

                      const SizedBox(height: 10),
                      Text('Qty: ${item['quantity']}',),
                      const SizedBox(height: 8),
                      Text('₹${item['sellingPrice']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
          // TOTAL
          Row(
            children: [
              Expanded(
                child: _infoTile(
                  title: 'Total Paid',
                  value: '₹${order.totalAmount.toStringAsFixed(0)}',
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _infoTile(
                  title: 'Saved',
                  value: '₹${order.totalSaved.toStringAsFixed(0)}',
                  green: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          // PAYMENT
          _paymentChip(order.paymentMethod,),
        ],
      ),
    );
  }

  Widget _infoTile({
    required String title,
    required String value,

    bool green = false,
  }) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12,),
      decoration: BoxDecoration(
        color: green ? Colors.green.withOpacity(0.08) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
            style: const TextStyle(fontSize: 12, color: Colors.grey,),
          ),

          const SizedBox(height: 6),
          Text(value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: green ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentChip(String method,) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10,),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(30),
      ),

      child: Text(method,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _month(int month) {

    const months = [

      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return months[month - 1];
  }
}
