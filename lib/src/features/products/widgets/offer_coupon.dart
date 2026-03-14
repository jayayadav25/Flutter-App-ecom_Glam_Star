import 'package:flutter/material.dart';

class OfferCouponSection extends StatelessWidget {
  const OfferCouponSection({super.key});

  @override
  Widget build(BuildContext context) {
    final offers = [
      "10% Instant Discount on HDFC Cards",
      "Flat ₹300 OFF using AXIS Bank",
      "No Cost EMI on ICICI Credit Card",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Available Offers",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 70,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: offers.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) => Container(
              width: 240,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_offer, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      offers[i],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
