import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/product_model.dart';
import '../data/wishlist_repository.dart';

class WishlistNotifier extends AsyncNotifier<List<ProductModel>> {
  late WishlistRepository _repo;

  @override
  Future<List<ProductModel>> build() async {
    _repo = WishlistRepository();
    await _repo.init();

    final items = _repo.getAll();
    _cleanInvalidItems(items);

    return _repo.getAll();
  }

  void toggle(ProductModel product) async {
    await _repo.toggle(product);
    state = AsyncData(_repo.getAll());
  }

  void remove(String productId) async {
    await _repo.remove(productId);
    state = AsyncData(_repo.getAll());
  }

  //  Clean corrupted items
  void _cleanInvalidItems(List<ProductModel> items) async {
    for (final p in items) {
      if (p.productId > 0 ||
          p.sellingPrice <= 0 ||
          p.images.isEmpty) {
        await _repo.remove(p.productId.toString());
      }
    }
  }
}

final wishlistProvider =
AsyncNotifierProvider<WishlistNotifier, List<ProductModel>>(
  WishlistNotifier.new,
);

//  Check helper
final isWishlistedProvider =
Provider.family<bool, int>((ref, productId) {
  final wishlist = ref.watch(wishlistProvider).value ?? [];
  return wishlist.any((p) => p.productId == productId);
});

