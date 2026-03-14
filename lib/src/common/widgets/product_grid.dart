import 'package:flutter/material.dart';
import '../../core/models/product_model.dart';
import '../../features/products/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, i) {
        return ProductCard(product: products[i]);
      },
    );
  }
}
