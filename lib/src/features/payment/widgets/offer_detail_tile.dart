import 'package:flutter/material.dart';
import '../../../core/models/bank_offer_model.dart';

class OfferDetailTile extends StatefulWidget {
  final BankOfferModel offer;

  const OfferDetailTile({super.key, required this.offer});

  @override
  State<OfferDetailTile> createState() => _OfferDetailTileState();
}

class _OfferDetailTileState extends State<OfferDetailTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(widget.offer.bankName),
            subtitle: Text(widget.offer.offerText),
            trailing: Icon(
              expanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
            ),
            onTap: () => setState(() => expanded = !expanded),
          ),

          if (expanded)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _row("Minimum Order", "₹${widget.offer.minOrder}"),
                  _row("Maximum Usage", "${widget.offer.maxUsage} per account"),
                  _row("Valid Till", widget.offer.validTill),
                  const Divider(),
                  Text(
                    "You get ₹${widget.offer.discount} OFF",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
