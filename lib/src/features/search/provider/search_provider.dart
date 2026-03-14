import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/light_product_model.dart';
import '../../products/providers/light_product_provider.dart';
import '../utils/search_map.dart';
import 'search_filter_provider.dart';
import '../utils/search_normalizer.dart';

final searchQueryProvider = StateProvider<String>((_) => '');

final searchResultsProvider = Provider<List<LightProductModel>>((ref) {
  final raw = ref.watch(searchQueryProvider);
  final filter = ref.watch(searchFilterProvider);
  final state = ref.watch(productsLightProvider);
  final products = state.items;

  if (raw.isEmpty) return [];

  // normalize raw input
  final normalized = normalize(raw);

  // split into words
  final words = normalized.split(' ');

  // map - canonical words
  final keywords = <String>{};

  for (final w in words) {
    final merged = mergeNoSpace(w);      // "t shirt" - "tshirt"
    final canon = searchMap[merged] ?? searchMap[w] ?? w;
    keywords.add(canon);
  }

  // detect gender filter
  String? gender;
  if (keywords.contains("men")) gender = "men";
  if (keywords.contains("women")) gender = "women";
  if (keywords.contains("kids")) gender = "kids";

  // Remove gender word from keywords to avoid conflict
  keywords.remove("men");
  keywords.remove("women");
  keywords.remove("kids");

  // filter products
  final results = products.where((p) {
    final title = p.title.toLowerCase();
    final category = p.category.toLowerCase();
    final sub = p.subCategory.toLowerCase();

    // GENDER FILTER
    // if (gender != null && category != gender) {
    //   return false;
    // }
    if (gender != null && !category.contains(gender)) {
      return false;
    }


    // Keyword match
    final matchesKeyword = keywords.isEmpty
        ? true // if only "men" searched show all men
        : keywords.any((k) =>
        title.contains(k) ||
        sub.contains(k) ||
        sub.contains(singular(k)) ||
        category.contains(k));

        // title.contains(k) ||
    //     sub.contains(k) ||
    //     category.contains(k));

    // Price filter
    final matchesPrice = p.sellingPrice >= filter.minPrice &&
        p.sellingPrice <= filter.maxPrice;

    return matchesKeyword && matchesPrice;
  }).toList();

  // sort
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
