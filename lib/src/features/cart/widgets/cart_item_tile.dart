import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/cart_item_model.dart';
import '../providers/cart_providers.dart';

class CartItemCard extends ConsumerWidget {
  final CartItemModel item;
  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.read(cartProvider.notifier);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  item.product.images.first.url,
                  width: 90,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 12),

              /// PRODUCT INFO
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// PRICE
                    Text(
                      "₹${item.product.sellingPrice}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// QUANTITY CONTROLLER
                    Row(
                      children: [
                        _qtyBtn(
                          icon: Icons.remove,
                          onTap: () =>
                              cart.decrement(item.product.productId.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "${item.quantity}",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        _qtyBtn(
                          icon: Icons.add,
                          onTap: () =>
                              cart.increment(item.product.productId.toString()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Divider(height: 24),

          /// DELIVERY + REMOVE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Delivery by Tomorrow",
                style: TextStyle(color: Colors.green),
              ),
              TextButton(
                onPressed: () =>
                    cart.removeFromCart(item.product.productId.toString()),
                child: const Text(
                  "REMOVE",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}
