import 'package:firebase_mastery_app/src/common/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/wishlist_item_model.dart';
import '../provider/wishlist_providers.dart';

class WishlistProductCard
    extends ConsumerWidget {

  final WishlistItemModel item;

  const WishlistProductCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {

    return GestureDetector(
      onTap: () {
        context.push(
          '/product/${item.productId}',
        );
      },

      child: Container(

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
          BorderRadius.circular(24),

          boxShadow: [
            BoxShadow(
              color:
              Colors.black.withOpacity(
                0.05,
              ),
              blurRadius: 20,
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Expanded(
              flex: 6,

              child: Stack(
                children: [

                  ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),

                    child: Image.network(
                      item.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),

                  Positioned(
                    top: 5,
                    left: 5,

                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                         color: Colors.green,
                       // color: AppColors.softGold,
                        borderRadius:
                        BorderRadius.circular(
                          30,
                        ),
                      ),

                      child: Text(
                        '${item.discount}% OFF',

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 12,
                    right: 12,

                    child: GestureDetector(
                      onTap: () async {

                        await ref
                            .read(
                          wishlistProvider
                              .notifier,
                        )
                            .toggleWishlist(
                          item: item,
                        );
                      },

                      child: Container(
                        padding:
                        const EdgeInsets.all(8),

                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 4,

              child: Padding(
                padding:
                const EdgeInsets.all(14),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    // Text(
                    //   item.brand,
                    //
                    //   style: TextStyle(
                    //     color:
                    //     Colors.grey.shade600,
                    //     fontSize: 12,
                    //     fontWeight:
                    //     FontWeight.w600,
                    //   ),
                    // ),

                    const SizedBox(height: 6),

                    Text(
                      item.title,

                      maxLines: 2,
                      overflow:
                      TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),

                    const Spacer(),

                    Row(
                      children: [

                        Text(
                          '₹${item.sellingPrice.toInt()}',

                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 8),

                        Text(
                          '₹${item.actualPrice.toInt()}',

                          style: TextStyle(
                            decoration:
                            TextDecoration
                                .lineThrough,

                            color:
                            Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../../../common/styles/colors.dart';
//
// import '../../data/models/wishlist_item_model.dart';
// import '../../providers/wishlist_providers.dart';
//
// class WishlistProductCard
//     extends ConsumerWidget {
//
//   final WishlistItemModel item;
//
//   const WishlistProductCard({
//     super.key,
//     required this.item,
//   });
//
//   @override
//   Widget build(
//       BuildContext context,
//       WidgetRef ref,
//       ) {
//
//     return GestureDetector(
//         onTap: () {
//           context.push(
//             '/product/${item.productId}',
//           );
//         },
//
//         child: Container(
//
//             decoration: BoxDecoration(
//               color: Colors.white,
//
//               borderRadius:
//               BorderRadius.circular(24),
//
//               boxShadow: [
//                 BoxShadow(
//                   color:
//                   Colors.black.withOpacity(
//                     0.05,
//                   ),
//                   blurRadius: 20,
//                 ),
//               ],
//             ),
//
//             child: Column(
//               crossAxisAlignment:
//               CrossAxisAlignment.start,
//
//               children: [
//
//               Expanded(
//               flex: 6,
//
//               child: Stack(
//                   children: [
//
//               ClipRRect(
//               borderRadius:
//               const BorderRadius.vertical(
//                   top: Radius.circular(24),
//             ),
//
//
//           children: [
//
//             Text(
//               item.brand,
//
//               style: TextStyle(
//                 color:
//                 Colors.grey.shade600,
//                 fontSize: 12,
//                 fontWeight:
//                 FontWeight.w600,
//               ),
//             ),
//
//             const SizedBox(height: 6),
//
//             Text(
//               item.title,
//
//               maxLines: 2,
//               overflow:
//               TextOverflow.ellipsis,
//
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight:
//                 FontWeight.w600,
//               ),
//             ),
//
//             const Spacer(),
//
//             Row(
//               children: [
//
//                 Text(
//                   '₹${item.sellingPrice.toInt()}',
//
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight:
//                     FontWeight.bold,
//                   ),
//                 ),
//
//                 const SizedBox(width: 8),
//
//                 Text(
//                   '₹${item.actualPrice.toInt()}',
//
//                   style: TextStyle(
//                     decoration:
//                     TextDecoration
//                         .lineThrough,
//
//                     color:
//                     Colors.grey.shade500,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),]
//     ),
//     ),
//     ],
//     ),
//     ),
//     );
//   }
// }