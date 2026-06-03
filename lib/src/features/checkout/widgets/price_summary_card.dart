//
// import 'package:flutter/material.dart';
// import '../../cart/widgets/convenience_charge.dart';
// import '../../cart/widgets/price_row.dart';
//
//
// class PriceSummaryCard extends StatefulWidget {
//   final double mrpTotal;
//   final double sellingTotal;
//   final double couponDiscount;
//   final int completedOrders;
//
//   const PriceSummaryCard({
//     super.key,
//     required this.mrpTotal,
//     required this.sellingTotal,
//     required this.couponDiscount,
//     required this.completedOrders,
//   });
//
//   @override
//   State<PriceSummaryCard> createState() => _PriceSummaryCardState();
// }
//
// class _PriceSummaryCardState extends State<PriceSummaryCard> {
//   bool expanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final productDiscount = widget.mrpTotal - widget.sellingTotal;
//     final bool isFree = widget.completedOrders < 4;
//     final double convenienceFee = isFree ? 0 : 50;
//
//     final orderTotal =
//         widget.sellingTotal - widget.couponDiscount + convenienceFee;
//
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           InkWell(
//             onTap: () => setState(() => expanded = !expanded),
//             child: Row(
//               children: [
//                 const Text(
//                   "Price Details",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Spacer(),
//                 Icon(
//                   expanded
//                       ? Icons.keyboard_arrow_up
//                       : Icons.keyboard_arrow_down,
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 12),
//
//           // Collapsed view
//           if (!expanded) ...[
//             Text(
//               "Order Total: ₹${orderTotal.toStringAsFixed(0)}",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               "You saved ₹${productDiscount.toStringAsFixed(0)}",
//               style: const TextStyle(color: Colors.green),
//             ),
//           ],
//
//           // Expanded view
//           if (expanded) ...[
//             PriceRow(
//               label: "Bag Total (MRP)",
//               value: widget.mrpTotal,
//               strike: true,
//               valueColor: Colors.black,
//             ),
//
//             PriceRow(
//               label: "Product Discount",
//               value: -productDiscount,
//               valueColor: Colors.green,
//             ),
//
//             PriceRow(
//               label: "Sub Total",
//               value: widget.sellingTotal,
//               valueColor: Colors.black,
//             ),
//
//             PriceRow(
//               label: "Coupon Discount",
//               value: -widget.couponDiscount,
//               valueColor: Colors.black,
//             ),
//
//             ConvenienceChargeRow(
//               completedOrders: widget.completedOrders,
//             ),
//
//             const Divider(),
//
//             PriceRow(
//               label: "Order Total",
//               value: orderTotal,
//               bold: true,
//               valueColor: Colors.black,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
