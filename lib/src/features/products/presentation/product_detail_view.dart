import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/product_model.dart';
import '../widgets/product_actions.dart';
import '../widgets/product_image_carousel.dart';
import '../widgets/return_policy_section.dart';

class ProductDetailView extends ConsumerStatefulWidget {

  final ProductModel product;

  const ProductDetailView({required this.product});

  @override
  ConsumerState<ProductDetailView> createState() => ProductDetailViewState();
}

class ProductDetailViewState extends ConsumerState<ProductDetailView> {

  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return ListView(
      children: [
        Stack(
          children: [
            ProductImageCarousel(product: p),
            ProductActionsBar(product: p),
          ],
        ),

        const SizedBox(height: 16),

        // Product info
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              // Rating
              Row(
                children: [
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "${p.averageRating}",
                          style: const TextStyle(
                              color: Colors.white),
                        ),
                        const Icon(Icons.star,
                            color: Colors.white, size: 14),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("Verified Buyers"),
                ],
              ),

              const SizedBox(height: 12),

              // Price
              Row(
                children: [
                  Text(
                    "₹${p.sellingPrice}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "₹${p.actualPrice}",
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${p.discount}% OFF",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Delivery
              Row(
                children: const [
                  Icon(Icons.local_shipping_outlined),
                  SizedBox(width: 6),
                  Text("Free delivery by Tomorrow"),
                ],
              ),

              const SizedBox(height: 12),

              // Stock
              Text(
                p.inStock ? "In Stock" : "Out of Stock",
                style: TextStyle(
                  color: p.inStock ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Description
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Product Details",
                style:
                TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(p.description),
            ],
          ),
        ),

        const ReturnPolicySection(),

        const SizedBox(height: 80),
      ],
    );
  }
}
