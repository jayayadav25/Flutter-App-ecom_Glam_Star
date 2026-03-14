import 'package:firebase_mastery_app/src/features/search/provider/search_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/light_product_model.dart';
import '../../products/providers/light_product_provider.dart';
import '../utils/search_normalizer.dart';
import '../utils/search_subcategory_aliases.dart';
import 'search_filter_provider.dart';

final searchResultsProvider = Provider<List<LightProductModel>>((ref) {
  final queryRaw = ref.watch(searchQueryProvider);
  if (queryRaw.isEmpty) return [];

  final query = normalize(queryRaw);
  final filter = ref.watch(searchFilterProvider);
  final paginatedState = ref.watch(productsLightProvider);

  final products = paginatedState.items;

  List<LightProductModel> results = products.where((p) {
    final title = normalize(p.title);
    final category = normalize(p.category);
    final subCategory = normalize(p.subCategory);

    // Match Exact normalized
    final matchDirect = title.contains(query) ||
        category.contains(query) ||
        subCategory.contains(query);

    // Match via ALIASES
    bool matchAlias = false;
    for (final entry in subcategoryAliases.entries) {
      final key = entry.key;
      final aliases = entry.value;

      if (subCategory == normalize(key)) {
        for (final alias in aliases) {
          if (query.contains(normalize(alias))) {
            matchAlias = true;
            break;
          }
        }
      }
    }

    final matchesPrice = p.sellingPrice >= filter.minPrice &&
        p.sellingPrice <= filter.maxPrice;

    return (matchDirect || matchAlias) && matchesPrice;
  }).toList();

  // sorting
  switch (filter.sortBy) {
    case 'PriceLow':
      results.sort((a, b) => a.sellingPrice.compareTo(b.sellingPrice));
      break;
    case 'PriceHigh':
      results.sort((a, b) => b.sellingPrice.compareTo(a.sellingPrice));
      break;
  }

  return results;
});
