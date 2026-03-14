import 'package:flutter/material.dart';
import '../../../core/models/order_model.dart';

class OrderTile extends StatefulWidget {
  final OrderModel order;

  const OrderTile({super.key, required this.order});

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final o = widget.order;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 0.1),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          ListTile(
            title: Text("Order #${o.id.substring(0, 6)}"),
            subtitle: Text(
              "₹${o.totalAmount} • ${o.paymentMethod}",
            ),
            trailing: Icon(
              expanded ? Icons.expand_less : Icons.expand_more,
            ),
            onTap: () => setState(() => expanded = !expanded),
          ),

          if (expanded)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Delivery Status: ${o.deliveryStatus}"),
                  const SizedBox(height: 8),

                  /// ITEMS
                  ...o.items.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          if (item['image'] != null)
                            Image.network(
                              item['image'],
                              width: 50,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image_not_supported),
                            ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item['title'] ?? 'Product',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text("₹${item['price'] ?? 0}"),
                        ],
                      ),
                    );
                  }),

                  const Divider(),

                  // Address
                  Text("Deliver To"),
                  Text(o.address['name'] ?? ''),
                  Text(o.address['phone'] ?? ''),
                  Text(o.address['addressLine'] ?? ''),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
