import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchHistoryProvider =
StateNotifierProvider<SearchHistoryNotifier, List<String>>(
      (_) => SearchHistoryNotifier(),
);

class SearchHistoryNotifier extends StateNotifier<List<String>> {
  SearchHistoryNotifier() : super([]);

  void add(String value) {
    if (value.isEmpty) return;
    state = [
      value,
      ...state.where((e) => e != value),
    ].take(10).toList();
  }

  void clear() => state = [];
}

final trendingSearchesProvider = Provider<List<String>>(
      (_) => const [
    "Tshirts",
    "Shoes",
    "Watches",
    "Sarees",
    "Dresses",
    "Jeans",
  ],
);
