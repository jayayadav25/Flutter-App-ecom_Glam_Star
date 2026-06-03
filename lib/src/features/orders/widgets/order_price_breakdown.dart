import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/text_styles.dart';
import '../../../core/models/order_model.dart';

class OrderPriceBreakdown extends ConsumerStatefulWidget {

  final OrderModel order;

  const OrderPriceBreakdown({super.key, required this.order,});

  @override
  ConsumerState<OrderPriceBreakdown> createState() => _OrderPriceBreakdownState();
}

class _OrderPriceBreakdownState extends ConsumerState<OrderPriceBreakdown> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // HEADER
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },

            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                children: [
                  // TOTAL
                  Text('₹${order.totalAmount.toStringAsFixed(0)}',
                    style: AppTextStyles.heading2,
                  ),
                  const SizedBox(width: 12),
                  // SAVED
                  if (order.totalSaved > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text('Saved ₹${order.totalSaved.toStringAsFixed(0)}',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  const Spacer(),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 300,),
                    turns: expanded ? 0.5 : 0,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // DETAILS
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300,),
            crossFadeState: expanded ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,

            firstChild: const SizedBox(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 22,),
              child: Column(
                children: [
                  // ACTUAL PRICE
                  _row(
                    label: 'Actual Price',
                    value: '₹${order.actualPrice.toStringAsFixed(0)}',
                  ),
                  // SELLING PRICE
                  _row(
                    label: 'Selling Price',
                    value: '₹${order.sellingPrice.toStringAsFixed(0)}',
                  ),
                  // PRODUCT DISCOUNT
                  _row(
                    label: 'Product Discount',
                    value: '- ₹${order.productDiscount.toStringAsFixed(0)}',
                    valueColor: Colors.green,
                  ),

                  // COUPON
                  if (order.couponDiscount > 0)
                    _row(
                      label: 'Coupon Discount',
                      value: '- ₹${order.couponDiscount.toStringAsFixed(0)}',
                      valueColor: Colors.green,
                    ),

                  // OFFER
                  if (order.offerDiscount > 0)
                    _row(
                      label: 'Offer Discount',
                      value: '- ₹${order.offerDiscount.toStringAsFixed(0)}',
                      valueColor: Colors.green,
                    ),

                  // SHIPPING
                  _row(
                    label: 'Convenience Fee',
                    value: order.shippingFee == 0 ? 'FREE'
                        : '₹${order.shippingFee.toStringAsFixed(0)}',
                  ),

                  const Divider(),
                  // TOTAL
                  _row(
                    label: 'Total Amount',
                    value: '₹${order.totalAmount.toStringAsFixed(0)}',
                    bold: true,
                  ),

                  const Divider(),
                  // PAYMENT METHOD
                  _row(
                    label: 'Payment Method',
                    value: order.paymentMethod,
                  ),
                  // PAYMENT STATUS
                  _row(
                    label: 'Payment Status',
                    value: order.paymentStatus,
                    valueColor: Colors.green,
                  ),

                  // ORDER STATUS
                  _row(
                    label: 'Order Status',
                    value: order.deliveryStatus,
                  ),

                  // COUPON CODE
                  if (order.couponCode != null)
                    _row(
                      label: 'Coupon Applied',
                      value: order.couponCode!,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row({
    required String label,
    required String value,
    bool bold = false,
    Color? valueColor,
  }) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 20,),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
              style: bold ? AppTextStyles.productTitle : AppTextStyles.bodyText1,
            ),
          ),

          Text(value,
            style: (bold ? AppTextStyles.productTitle
                : AppTextStyles.bodyText1).copyWith(
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
