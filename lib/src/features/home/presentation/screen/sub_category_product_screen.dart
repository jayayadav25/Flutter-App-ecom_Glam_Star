import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../products/presentation/light_product_card.dart';
import '../../providers/sub_category_provider.dart';


class SubCategoryProductsScreen extends ConsumerWidget {
  const SubCategoryProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(subCategoryProductsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.62,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: products.length,
            itemBuilder: (_, i) =>
                LightProductCard(product: products[i]),
          );
        },
      ),
    );
  }
}
