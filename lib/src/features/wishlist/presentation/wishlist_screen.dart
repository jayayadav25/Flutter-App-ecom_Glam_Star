import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/wishlist_providers.dart';
import '../widgets/wishlist_grid_Card.dart';
import 'empty_wishlist_view.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistAsync = ref.watch(wishlistProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wishlist"),
        centerTitle: true,
      ),
      body: wishlistAsync.when(
        loading: () =>
        const Center(child: CircularProgressIndicator()),

        error: (e, _) =>
            Center(child: Text("Error: $e")),

        data: (items) {
          /// SAFE FILTER
          final products = items
              .where((p) => p.productId > 0 && p.images.isNotEmpty)
              .toList();

          if (products.isEmpty) {
            return const EmptyWishlistView();
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.62, // Amazon-like
            ),
            itemCount: products.length,
            itemBuilder: (_, i) =>
                WishlistGridCard(product: products[i]),
          );
        },
      ),
    );
  }
}
