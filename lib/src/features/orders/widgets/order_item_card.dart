import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/text_styles.dart';

class OrderItemCard extends ConsumerWidget {
  final Map<String, dynamic> item;

  const OrderItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(14,),
            child: CachedNetworkImage(
              imageUrl: item['image'] ?? '',
              width: 70,
              height: 90,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) {
                return Container(
                  width: 70,
                  height: 90,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image,),
                );
              },
            ),
          ),

          const SizedBox(width: 14),
          // DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'] ?? 'Product',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.productTitle,
                ),

                const SizedBox(height: 6,),
                Text('Qty: ${item['quantity']}',),
                const SizedBox(height: 8,),
                Text('₹${item['price']}',
                  style: AppTextStyles.productPrice,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}