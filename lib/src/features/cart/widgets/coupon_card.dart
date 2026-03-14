import 'package:flutter/material.dart';
import '../../../core/models/coupon_model.dart';


class CouponCard extends StatelessWidget {
  final CouponModel coupon;
  final String timeLeft;
  final VoidCallback onApply;

  const CouponCard({
    required this.coupon,
    required this.timeLeft,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// BRAND
                const Text(
                  "TRENDORA\nFASHION",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                const SizedBox(width: 18),

                /// TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coupon.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        coupon.description,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Expires in ${timeLeft.replaceAll(':', 'h ')}s",
                        style: const TextStyle(
                          color: Colors.pink,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                /// SAVE PILL
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Save ₹${coupon.discount.toInt()}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// DASHED DIVIDER
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),

          /// BOTTOM SECTION
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Text(
                  coupon.code,
                  style: const TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: onApply,
                  child: const Text(
                    "Apply",
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
