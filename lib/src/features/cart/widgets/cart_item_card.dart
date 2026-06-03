import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/text_styles.dart';
import '../../../core/models/cart_item_model.dart';
import '../../products/widgets/deliver_eta_helper.dart';
import '../../products/widgets/delivery_eta_chip.dart';
import '../../products/widgets/quantity_selector.dart';
import '../../products/widgets/remove_cart_button.dart';
import '../providers/cart_providers.dart';

class PremiumCartItemCard extends ConsumerWidget {

  final CartItemModel item;

  const PremiumCartItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final cartNotifier = ref.read(cartProvider.notifier);
    final discountPercent = item.actualPrice > item.sellingPrice ?
    (((item.actualPrice - item.sellingPrice) / item.actualPrice) * 100).round() : 0;
    final deliveryText = DeliveryEtaHelper.getDeliveryText(
      title: item.title,
      productId: item.productId,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10,),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: item.image,
              width: 100,
              height: 125,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TITLE + REMOVE
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),

                    RemoveCartButton(
                      onRemove: () async {
                        await cartNotifier.removeFromCart(item.productId,);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                // PRICE
                Row(
                  children: [
                    Text(
                      "₹${item.sellingPrice}",
                      style: AppTextStyles.productTitle,
                    ),
                    const SizedBox(width: 6),
                    if (item.actualPrice >
                        item.sellingPrice)
                      Flexible(
                        child: Text(
                          "₹${item.actualPrice}",
                          style: AppTextStyles.oldPrice,
                        ),
                      ),
                    const SizedBox(width: 8),
                    if (discountPercent > 0)
                      Text("$discountPercent% OFF",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                // QUANTITY
                QuantitySelector(
                  quantity: item.quantity,
                  onIncrement: () {
                    cartNotifier.increment(
                      item.productId,
                    );
                  },
                  onDecrement: () {
                    cartNotifier.decrement(
                      item.productId,
                    );
                  },
                ),

                const SizedBox(height: 10),

                // DELIVERY
                DeliveryEtaChip(
                  text: deliveryText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
