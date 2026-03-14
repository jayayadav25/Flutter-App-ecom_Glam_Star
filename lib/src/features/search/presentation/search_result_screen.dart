import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/search_provider.dart';
import '../widgets/search_grid_card.dart';

class SearchResultsScreen extends ConsumerWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var results = ref.watch(searchResultsProvider);

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: results.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.62,
            ),
            itemBuilder: (_, i) =>
                SearchGridCard(product: results[i]),
          ),
        ),
      ],
    );
  }
}
