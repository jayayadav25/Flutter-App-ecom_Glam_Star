import 'package:flutter/material.dart';
import '../../../core/models/order_model.dart';
import '../services/invoice_service.dart';

class InvoiceSection extends StatelessWidget {
  final OrderModel order;

  const InvoiceSection({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(Icons.receipt_long,),
          const SizedBox(width: 14),
          const Expanded(
            child: Text('Download Invoice',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await InvoiceService.generateInvoice(
                context,
                order,
              );
            },

            child: const Text('Download',),
          ),
        ],
      ),
    );
  }
}

