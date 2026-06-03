import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/text_styles.dart';

class OrderProductTile extends ConsumerWidget {
  final Map<String, dynamic> item;

  const OrderProductTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16,),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18,),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14,),
            child: CachedNetworkImage(
              imageUrl: item['image'],
              width: 80,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.productTitle,),
                const SizedBox(height: 8,),
                Text('₹${item['price']}',),
              ],
            ),
          ),
        ],
      ),
    );
  }
}