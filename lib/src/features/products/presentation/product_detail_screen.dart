import 'package:firebase_mastery_app/src/features/products/presentation/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';
import '../providers/product_detail_provider.dart';
import '../widgets/bottom_action_bar.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailProvider(productId));

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: productAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, _) => Center(
          child: Text(e.toString()),
        ),
        data: (product) {
          return ProductDetailView(product: product);
        },
      ),
      bottomNavigationBar: productAsync.whenOrNull(
        data: (product) => LuxuryBottomBar(product: product),
      ),
    );
  }
}

