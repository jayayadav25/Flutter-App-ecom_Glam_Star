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















// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
//
// class OrderItemsSection extends StatelessWidget {
//   final List<Map<String, dynamic>> items;
//
//   const OrderItemsSection({
//     super.key,
//     required this.items,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: items.map((item) {
//         return Container(
//           margin: const EdgeInsets.only(bottom: 16),
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Row(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: CachedNetworkImage(
//                   imageUrl: item['image'],
//                   width: 80,
//                   height: 100,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment:
//                   CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       item['title'],
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text('Qty: ${item['qty']}'),
//                   ],
//                 ),
//               ),
//               Text(
//                 '₹${item['price']}',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
// }