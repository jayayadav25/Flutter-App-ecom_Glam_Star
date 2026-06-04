import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';
import '../provider/wishlist_providers.dart';
import '../widgets/wishlist_empty_view.dart';
import '../widgets/wishlist_loading_grid.dart';
import '../widgets/wishlist_product_card.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final wishlistAsync = ref.watch(wishlistProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('My Wishlist',
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: wishlistAsync.when(
        loading: () => const WishlistLoadingGrid(),
        error: (e, _) => Center(
          child: Text(e.toString()),
        ),

        data: (items) {
          if (items.isEmpty) {
            return const WishlistEmptyView();
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.62,
            ),

            itemBuilder: (_, index) {
              return WishlistProductCard(
                item: items[index],
              );
            },
          );
        },
      ),
    );
  }
}
