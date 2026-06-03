import 'package:firebase_mastery_app/src/features/search/provider/search_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/light_product_model.dart';
import '../../products/providers/light_product_provider.dart';
import '../utils/search_subcategory_aliases.dart';
import '../widgets/search_normalizer.dart';
import 'search_filter_provider.dart';

final searchResultsProvider = Provider<List<LightProductModel>>((ref) {

  final rawQuery = ref.watch(searchQueryProvider);
  if (rawQuery.trim().isEmpty) {
    return [];
  }

  final filter = ref.watch(searchFilterProvider);
  final state = ref.watch(productsLightProvider);
  final products = state.items;
  final query = normalize(rawQuery);
  final queryWords = query.split(' ');
  final normalizedWords = queryWords.map((word) {
    final clean = normalize(word);
    for (final entry in subcategoryAliases.entries) {
      if (entry.value.contains(clean)) {
        return entry.key;
      }
    }

    return clean;
  }).toSet();

  final List<MapEntry<LightProductModel, int>> scored = [];
  for (final p in products) {
    final title = normalize(p.title);
    final category = normalize(p.category);
    final subCategory = normalize(p.subCategory);
    int score = 0;
    for (final keyword in normalizedWords) {
      if (title.contains(keyword)) {
        score += 5;
      }

      if (subCategory.contains(keyword)) {
        score += 4;
      }

      if (category.contains(keyword)) {
        score += 3;
      }
    }

    final matchesPrice = p.sellingPrice >= filter.minPrice && p.sellingPrice <= filter.maxPrice;
    if (score > 0 && matchesPrice) {
      scored.add(MapEntry(p, score));
    }
  }

  scored.sort((a, b) => b.value.compareTo(a.value));

  List<LightProductModel> results = scored.map((e) => e.key).toList();

  switch (filter.sortBy) {
    case 'PriceLow':
      results.sort((a, b) => a.sellingPrice.compareTo(b.sellingPrice),);
      break;

    case 'PriceHigh':
      results.sort((a, b) => b.sellingPrice.compareTo(a.sellingPrice),);
      break;
  }

  return results;
});