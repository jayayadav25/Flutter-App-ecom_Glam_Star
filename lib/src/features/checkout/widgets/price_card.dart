import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceCard extends ConsumerWidget {

  final double actualPrice;

  final double sellingPrice;

  final double shippingFee;

  final double couponDiscount;


  final double total;

  const PriceCard({
    super.key,

    required this.actualPrice,

    required this.sellingPrice,

    required this.shippingFee,

    required this.couponDiscount,


    required this.total,
  });

  /// TOTAL SAVED
  double get totalSaved {

    return
      (actualPrice - sellingPrice)
          + couponDiscount;
  }

  Widget priceRow({
    required String title,
    required String value,

    bool bold = false,

    bool green = false,

    bool strike = false,
  }) {

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),

      child: Row(
        children: [

          Text(
            title,

            style: TextStyle(
              fontSize: 14,

              fontWeight:
              bold
                  ? FontWeight.bold
                  : FontWeight.w500,

              color:
              Colors.grey.shade800,
            ),
          ),

          const Spacer(),

          Text(
            value,

            style: TextStyle(
              fontSize: 14,

              color: green
                  ? Colors.green
                  : Colors.black,

              fontWeight:
              bold
                  ? FontWeight.bold
                  : FontWeight.w600,

              decoration:
              strike
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withOpacity(0.05),

            blurRadius: 20,

            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          /// TITLE
          const Text(
            'Price Details',

            style: TextStyle(
              fontSize: 16,

              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 22),

          /// ACTUAL PRICE
          priceRow(
            title: 'Actual Price',

            value:
            '₹${actualPrice.toStringAsFixed(0)}',

            strike: true,
          ),

          /// SELLING PRICE
          priceRow(
            title: 'Selling Price',

            value:
            '₹${sellingPrice.toStringAsFixed(0)}',
          ),

          /// PRODUCT SAVINGS
          priceRow(
            title: 'Product Discount',

            value:
            '- ₹${(actualPrice - sellingPrice).toStringAsFixed(0)}',

            green: true,
          ),

          /// COUPON DISCOUNT
          if (couponDiscount > 0)

            priceRow(
              title: 'Coupon Discount',

              value:
              '- ₹${couponDiscount.toStringAsFixed(0)}',

              green: true,
            ),

          // /// OFFER DISCOUNT
          // if (offerDiscount > 0)
          //
          //   priceRow(
          //     title: 'Offer Discount',
          //
          //     value:
          //     '- ₹${offerDiscount.toStringAsFixed(0)}',
          //
          //     green: true,
          //   ),

          /// SHIPPING
          priceRow(
            title: 'Convenience Fee',

            value:
            shippingFee == 0
                ? 'FREE'
                : '₹${shippingFee.toStringAsFixed(0)}',

            green: shippingFee == 0,
          ),

          const Divider(
            height: 30,
          ),

          /// TOTAL
          priceRow(
            title: 'Total Amount',

            value:
            '₹${total.toStringAsFixed(0)}',

            bold: true,
          ),

          const SizedBox(height: 14),

          /// SAVINGS CONTAINER
          Container(
            width: double.infinity,

            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),

            decoration: BoxDecoration(
              color:
              Colors.green.withOpacity(0.08),

              borderRadius:
              BorderRadius.circular(14),
            ),

            child: Text(
              '🎉 You saved ₹${totalSaved.toStringAsFixed(0)} on this order',

              style: const TextStyle(
                color: Colors.green,

                fontWeight: FontWeight.w700,

                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


















// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class PriceCard extends ConsumerWidget {
//
//   final double subtotal;
//   final double shipping;
//   final double discount;
//   final double total;
//
//   const PriceCard({super.key,
//     required this.subtotal,
//     required this.shipping,
//     required this.discount,
//     required this.total,
//   });
//
//   Widget row({
//     required String title,
//     required String value,
//     bool bold = false,
//     Color? color,
//   }) {
//
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14,),
//       child: Row(
//         children: [
//           Text(title,
//             style: TextStyle(
//               fontWeight: bold
//                   ? FontWeight.bold
//                   : FontWeight.w500,
//             ),
//           ),
//           const Spacer(),
//           Text(value,
//             style: TextStyle(
//               color: color,
//               fontWeight: bold
//                   ? FontWeight.bold
//                   : FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//
//     return Container(
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 18,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//
//       child: Column(
//         children: [
//           row(
//             title: 'Subtotal',
//             value: '₹${subtotal.toStringAsFixed(0)}',
//           ),
//           row(
//             title: 'Shipping Fee',
//             value: shipping == 0 ? 'FREE'
//                 : '₹${shipping.toStringAsFixed(0)}',
//
//             color: shipping == 0
//                 ? Colors.green : null,
//           ),
//           row(
//             title: 'Discount',
//             value: '- ₹${discount.toStringAsFixed(0)}',
//             color: Colors.green,
//           ),
//           const Divider(height: 30),
//           row(
//             title: 'Total Amount',
//             value:
//             '₹${total.toStringAsFixed(0)}',
//
//             bold: true,
//           ),
//         ],
//       ),
//     );
//   }
// }