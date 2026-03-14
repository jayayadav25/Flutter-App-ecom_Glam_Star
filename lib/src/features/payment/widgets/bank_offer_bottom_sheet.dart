import 'package:flutter/material.dart';
import '../../../core/models/bank_offer_model.dart';

class BankOfferBottomSheet extends StatelessWidget {
  final BankOfferModel offer;

  const BankOfferBottomSheet({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(offer.logoUrl, height: 60),
          ),
          const SizedBox(height: 16),
          Text(
            offer.bankName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(offer.offerText),
          const Divider(),
          Text("Minimum Order: ₹${offer.minOrder}"),
          Text("Max Usage: ${offer.maxUsage} per account"),
          Text("Valid Till: ${offer.validTill}"),
          const SizedBox(height: 12),
          Text(
            "You get ₹${offer.discount} OFF",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
