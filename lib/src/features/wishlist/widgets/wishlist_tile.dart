// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../widgets/images.dart';
// import '../../../core/models/product_model.dart';
// import '../provider/wishlist_providers.dart';
//
// class WishlistItemTile extends ConsumerWidget {
//   final ProductModel product;
//
//   const WishlistItemTile({Key? key, required this.product}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 14),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12.withOpacity(0.06),
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           )
//         ],
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.network(
//                product.images.first.url,
//               fit: BoxFit.cover,
//             ),
//
//           ),
//           const SizedBox(width: 14),
//
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   product.title,
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   "₹${product.sellingPrice}",
//                   style: const TextStyle(fontSize: 15),
//                 ),
//               ],
//             ),
//           ),
//
//           IconButton(
//             icon: const Icon(Icons.favorite, color: Colors.red),
//             onPressed: () {
//               ref.read(wishlistProvider.notifier).toggle(product);
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
