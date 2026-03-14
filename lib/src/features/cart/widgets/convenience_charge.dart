import 'package:flutter/material.dart';

class ConvenienceChargeRow extends StatelessWidget {
  final int completedOrders; // number of previous orders

  const ConvenienceChargeRow({
    super.key,
    required this.completedOrders,
  });

  static const int freeOrderLimit = 4;
  static const double chargeAmount = 50;

  bool get isFree => completedOrders < freeOrderLimit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Convenience Charges",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          Text(
            isFree ? "FREE" : "₹$chargeAmount",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isFree ? Colors.green : Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }
}
