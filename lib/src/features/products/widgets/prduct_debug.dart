import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_providers.dart';

class ProductDebugScreen extends ConsumerWidget {
  const ProductDebugScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(allProductsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("DEBUG")),
      body: productsAsync.when(
        loading: () {
          debugPrint("provider loading");
          return const Center(child: CircularProgressIndicator());
        },
        error: (e, _) {
          debugPrint("Provider error = $e");
          return Center(child: Text(e.toString()));
        },
        data: (products) {
          debugPrint("Provider called");
          debugPrint("Products count = ${products.length}");
          if (products.isNotEmpty) {
            debugPrint("Product data = ${products.first.toJson()}");
            debugPrint("Product images = ${products.first.images}");
          }
          return const Center(child: Text("Check console logs"));
        },
      ),
    );
  }
}
