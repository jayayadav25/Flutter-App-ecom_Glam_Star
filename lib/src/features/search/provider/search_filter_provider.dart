import 'package:flutter_riverpod/flutter_riverpod.dart';

// Filter state
class SearchFilterState {
  final double minPrice;
  final double maxPrice;
  final String sortBy;

  const SearchFilterState({
    required this.minPrice,
    required this.maxPrice,
    required this.sortBy,
  });

  factory SearchFilterState.initial() {
    return const SearchFilterState(
      minPrice: 0,
      maxPrice: 10000,
      sortBy: 'Relevance',
    );
  }

  SearchFilterState copyWith({
    double? minPrice,
    double? maxPrice,
    String? sortBy,
  }) {
    return SearchFilterState(
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}

// Filter provider
final searchFilterProvider =
StateNotifierProvider<SearchFilterNotifier, SearchFilterState>(
      (ref) => SearchFilterNotifier(),
);

class SearchFilterNotifier extends StateNotifier<SearchFilterState> {
  SearchFilterNotifier() : super(SearchFilterState.initial());

  void updatePrice(double min, double max) {
    state = state.copyWith(minPrice: min, maxPrice: max);
  }

  void updateSort(String sort) {
    state = state.copyWith(sortBy: sort);
  }

  void reset() {
    state = SearchFilterState.initial();
  }
}
