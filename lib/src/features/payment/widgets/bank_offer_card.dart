import 'package:flutter/material.dart';
import '../../../core/models/bank_offer_model.dart';
import 'bank_offer_bottom_sheet.dart';


class BankOfferCard extends StatelessWidget {
  final BankOfferModel offer;

  const BankOfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:Text(offer.logoUrl,),
      title: Text("${offer.bankName} Offer"),
      subtitle: Text(offer.offerText),
      trailing: IconButton(
        icon: const Icon(Icons.info_outline),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => BankOfferBottomSheet(offer: offer),
          );
        },
      ),
    );
  }
}
