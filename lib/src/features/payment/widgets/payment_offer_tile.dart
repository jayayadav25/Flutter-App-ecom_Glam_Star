import 'package:firebase_mastery_app/src/features/payment/widgets/payment_offer_bottomsheet.dart';
import 'package:flutter/material.dart';
import '../../../core/models/bank_offer_model.dart';

class PaymentOfferTile extends StatelessWidget {
  final List<BankOfferModel> offers;

  const PaymentOfferTile({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(Icons.comment_bank_outlined),
        title: Text(
          "Save more with ${offers.length} offers",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        subtitle: Text("Card, UPI, EMI etc."),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => PaymentOfferBottomSheet(offers: offers),
          );
        },
      ),
    );
  }
}
