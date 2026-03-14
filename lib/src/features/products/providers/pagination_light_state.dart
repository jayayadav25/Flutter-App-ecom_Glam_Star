import '../../../core/models/light_product_model.dart';

class PaginatedLightState {
  final List<LightProductModel> items;
  final bool isLoading;
  final bool hasMore;
  final String? error;

  const PaginatedLightState({
    required this.items,
    required this.isLoading,
    required this.hasMore,
    this.error,
  });

  factory PaginatedLightState.initial() {
    return const PaginatedLightState(
      items: [],
      isLoading: true,
      hasMore: true,
      error: null,
    );
  }

  PaginatedLightState copyWith({
    List<LightProductModel>? items,
    bool? isLoading,
    bool? hasMore,
    String? error,
  }) {
    return PaginatedLightState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      error: error,
    );
  }
}
