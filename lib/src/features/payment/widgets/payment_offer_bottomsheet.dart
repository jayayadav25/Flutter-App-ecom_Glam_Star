import 'package:flutter/material.dart';
import '../../../core/models/bank_offer_model.dart';
import 'offer_detail_tile.dart';

class PaymentOfferBottomSheet extends StatelessWidget {
  final List<BankOfferModel> offers;

  const PaymentOfferBottomSheet({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Payment Offers",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),

          ...offers.map(
                (offer) => OfferDetailTile(offer: offer),
          ),
        ],
      ),
    );
  }
}
