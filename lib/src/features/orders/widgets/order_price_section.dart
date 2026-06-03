import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/text_styles.dart';

class OrderPriceSection extends ConsumerWidget {
  final double totalAmount;

  const OrderPriceSection({
    super.key,
    required this.totalAmount,
  });

  Widget _row({
    required String label,
    required String value,
    bool bold = false,
  }) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 10,),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
              style: bold ? AppTextStyles.productTitle
                  : AppTextStyles.bodyText1,
            ),
          ),
          Text(value,
            style: bold ? AppTextStyles.productTitle
                : AppTextStyles.bodyText1,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22,),
      ),
      child: Column(
        children: [
          _row(
            label: 'Subtotal',
            value: '₹${totalAmount.toStringAsFixed(0)}',
          ),

          _row(
            label: 'Delivery',
            value: 'FREE',
          ),

          _row(
            label: 'Discount',
            value: '- ₹0',
          ),

          const Divider(),

          _row(
            label: 'Total Amount',
            value: '₹${totalAmount.toStringAsFixed(0)}',
            bold: true,
          ),
        ],
      ),
    );
  }
}