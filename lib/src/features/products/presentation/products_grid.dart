import 'package:flutter/material.dart';
import '../../../core/models/product_model.dart';
import '../widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;
  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (_, i) => ProductCard(product: products[i]),
    );
  }
}
