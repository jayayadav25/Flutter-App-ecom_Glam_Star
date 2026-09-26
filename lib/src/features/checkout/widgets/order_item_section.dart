import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/cart_item_model.dart';
import 'order_item_tile.dart';

class OrderItemsSection extends ConsumerWidget {

  final List<CartItemModel> items;
  final String deliveryDate;

  const OrderItemsSection({super.key,
    required this.items,
    required this.deliveryDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    return Column(
      children: items.map((item) {
        return OrderItemTile(
          image: item.image,
          title: item.title,
          quantity: item.quantity,
          price: item.sellingTotal,
          mrpPrice: item.actualPrice,
          sellingPrice: item.sellingPrice,
        );
      }).toList(),
    );
  }
}
