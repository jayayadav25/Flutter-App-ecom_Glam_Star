import 'package:flutter/material.dart';

class CartOfferBanner extends StatelessWidget {
  const CartOfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: const [
          Icon(Icons.local_offer, color: Colors.green),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Save ₹300 more using bank offers & coupons",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 14),
        ],
      ),
    );
  }
}
