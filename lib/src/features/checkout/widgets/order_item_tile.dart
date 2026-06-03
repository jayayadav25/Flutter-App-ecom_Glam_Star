import 'package:firebase_mastery_app/src/common/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderItemTile extends ConsumerWidget {
  final String image;
  final String title;
  final int quantity;
  final double price;
  final double mrpPrice;
  final double sellingPrice;


  const OrderItemTile({
    super.key,
    required this.image,
    required this.title,
    required this.quantity,
    required this.price,
    required this.mrpPrice,
    required this.sellingPrice,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final savedPrice = mrpPrice - sellingPrice;
    final discountPercentage = ((savedPrice / mrpPrice) * 100).toStringAsFixed(0);
    return Container(
      margin: const EdgeInsets.only(bottom: 5,),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: CachedNetworkImage(
              imageUrl: image,
              width: 90,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:AppTextStyles.productTitle
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text('₹${sellingPrice.toStringAsFixed(0)}',
                      style: AppTextStyles.productPrice
                    ),

                    const SizedBox(width: 8),

                    Text('₹${mrpPrice.toStringAsFixed(0)}',
                      style:AppTextStyles.oldPrice
                    ),

                    const SizedBox(width: 8),
                    Text(
                      '$discountPercentage% OFF',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
            const SizedBox(height: 5),
            Text(
              'You saved ₹${savedPrice.toStringAsFixed(0)}',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 13,)),
                Text('Qty: $quantity',),

              ],
            ),
          ),


        ],
      ),
    );
  }
}
