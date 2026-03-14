import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/light_product_model.dart';
import '../../home/providers/home_provider.dart';
import 'pagination_light_state.dart';

final productsLightProvider =
StateNotifierProvider<ProductsLightNotifier, PaginatedLightState>(
      (ref) => ProductsLightNotifier(ref),
);

class ProductsLightNotifier extends StateNotifier<PaginatedLightState> {
  ProductsLightNotifier(this.ref) : super(PaginatedLightState.initial()) {
    fetchNext();
  }

  final Ref ref;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DocumentSnapshot? _lastDoc;
  bool _loading = false;
  static const int _limit = 20;

  // UI tab
  // String? _mapTabToCategory(HomeTab tab) {
  //   switch (tab) {
  //     case HomeTab.men:
  //       return "Men";
  //     case HomeTab.women:
  //       return "Women";
  //     case HomeTab.kids:
  //       return "Kids";
  //     case HomeTab.home:
  //     default:
  //       return null; // HOME = no filter
  //   }
  // }

  void resetAndFetch() {
    _lastDoc = null;
    state = PaginatedLightState.initial();
    fetchNext();
  }

  Future<void> fetchNext() async {
    if (_loading || !state.hasMore) return;
    _loading = true;

    try {
      final tab = ref.read(homeTabProvider);

      Query query = _db.collection('products_light');

      // Category Filter
      if (tab != HomeTab.home) {
        query = query.where('category', isEqualTo: tab.name);
      }

      // Order only for home
      if (tab == HomeTab.home) {
        query = query.orderBy('product_id');
      }

      if (_lastDoc != null) {
        query = query.startAfterDocument(_lastDoc!);
      }

      query = query.limit(_limit);

      final snapshot = await query.get();

      final newItems = snapshot.docs
          .map((d) =>
          LightProductModel.fromJson(d.data() as Map<String, dynamic>))
          .toList();

      _lastDoc =
      snapshot.docs.isNotEmpty ? snapshot.docs.last : _lastDoc;

      state = state.copyWith(
        items: [...state.items, ...newItems],
        isLoading: false,
        hasMore: newItems.length == _limit,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    } finally {
      _loading = false;
    }
  }

}
