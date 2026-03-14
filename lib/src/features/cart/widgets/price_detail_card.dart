import 'package:flutter/material.dart';
import 'convenience_charge.dart';
import 'price_row.dart';


class PriceDetailsCard extends StatelessWidget {
  final double mrpTotal;
  final double sellingTotal;
  final double couponDiscount;

  const PriceDetailsCard({
    super.key,
    required this.mrpTotal,
    required this.sellingTotal,
    required this.couponDiscount,
  });

  @override
  Widget build(BuildContext context) {

    final productDiscount = mrpTotal - sellingTotal;
    final orderTotal = sellingTotal - couponDiscount;
    final int completedOrders = 1;
    final bool isFree = completedOrders < 4;
    final double convenienceFee = isFree ? 0 : 50;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Price Details",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),

        PriceRow(
          label: "Bag Total (MRP)",
          value: mrpTotal,
          strike: true,
          valueColor: Colors.black,
        ),

        PriceRow(
          label: "Product Discount",
          value: -productDiscount,
          valueColor: Colors.green,
        ),

        PriceRow(
          label: "Sub Total",
          value: sellingTotal,
          valueColor: Colors.black,
        ),

        PriceRow(
          label: "Coupon Discount",
          value: -couponDiscount,
          valueColor: Colors.black,
        ),

        ConvenienceChargeRow(
          completedOrders: completedOrders,
        ),


        const Divider(),

        PriceRow(
          label: "Order Total",
          value: orderTotal,
          bold: true,
          valueColor: Colors.black,
        ),
      ],
    );
  }
}
