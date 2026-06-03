import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/text_styles.dart';
import '../../products/presentation/light_product_card.dart';
import '../../products/providers/light_product_provider.dart';
import '../providers/editorial_filter_provider.dart';

class HomeProductGrid extends ConsumerWidget {
  const HomeProductGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final state = ref.watch(productsLightProvider);
    final filter = ref.watch(editorialFilterProvider);

    return SliverPadding(

      padding: const EdgeInsets.fromLTRB(10, 20, 10, 40,
      ),

      sliver: SliverMainAxisGroup(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: 8,
                bottom: 18,
              ),
              child: Text(
                'Explore Products',
                style: AppTextStyles.heading1,
              ),
            ),
          ),

          SliverGrid(
            delegate:
            SliverChildBuilderDelegate(
                  (_, index) {
                if (index >= state.items.length) {
                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }
                return LightProductCard(
                  product: state.items[index],
                );
              },

              childCount: state.hasMore
                  ? state.items.length + 1
                  : state.items.length,
            ),

            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .58,
              crossAxisSpacing: 10,
              mainAxisSpacing: 14,
            ),
          ),
        ],
      ),
    );
  }
}