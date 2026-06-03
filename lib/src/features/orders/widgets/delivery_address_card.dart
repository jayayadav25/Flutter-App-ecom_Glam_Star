import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/text_styles.dart';
import '../../../core/models/order_model.dart';

class DeliveryAddressCard extends ConsumerWidget {

  final OrderModel order;

  const DeliveryAddressCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final address = order.address;
    return Container(width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Delivery Details',
            style: AppTextStyles.heading2,
          ),
          const SizedBox(height: 22),
          // ADDRESS
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.location_on_outlined,
                  size: 24,
                ),
              ),

              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NAME
                    Text(address['name'] ?? '',
                      style: AppTextStyles.productTitle,
                    ),

                    const SizedBox(height: 10),
                    // ADDRESS
                    Text('${address['address'] ?? ''}, '
                          '${address['city'] ?? ''} - '
                          '${address['zipCode'] ?? ''}',
                      style: AppTextStyles.bodyText1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(),
          const SizedBox(height: 18),

          // PHONE
          Row(
            children: [
              const Icon(Icons.phone_outlined,),
              const SizedBox(width: 14),
              Text(address['phone'] ?? '',
                style: AppTextStyles.bodyText1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
