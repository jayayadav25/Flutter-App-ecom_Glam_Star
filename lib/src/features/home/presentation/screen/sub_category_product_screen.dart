import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/styles/colors.dart';
import '../../../../common/styles/text_styles.dart';
import '../../../products/presentation/light_product_card.dart';
import '../../providers/sub_category_provider.dart';

class SubCategoryProductsScreen extends ConsumerWidget {
  const SubCategoryProductsScreen({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(subCategoryProductsProvider);
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffold,
        title: const Text('Products',
          style: AppTextStyles.sectionTitle,),
      ),

      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(),),
        error: (e, _) => Center(
              child: Text(e.toString()),
            ),
        data: (products) {
          if (products.isEmpty) {
            return const Center(
              child: Text('No products found'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .58,
              crossAxisSpacing: 10,
              mainAxisSpacing: 14,
            ),
            itemBuilder: (_, index) {
              return LightProductCard(
                product: products[index],
              );
            },
          );
        },
      ),
    );
  }
}
