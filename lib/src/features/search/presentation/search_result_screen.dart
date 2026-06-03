import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/search_provider.dart';
import '../widgets/search_grid_card.dart';
import 'empty_search_screen.dart';

class SearchResultsScreen extends ConsumerWidget {
  const SearchResultsScreen({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final resultsAsync = ref.watch(searchResultsProvider);
    final query = ref.watch(searchQueryProvider);
    return resultsAsync.when(
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (e, _) {
        return Center(
          child: Text(e.toString()),
        );
      },
      data: (results) {
        if (results.isEmpty) {
          return EmptySearchScreen(
            query: query,
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: results.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.56,
          ),
          itemBuilder: (_, index) {
            return SearchGridCard(
              product: results[index],
            );
          },
        );
      },
    );
  }
}
