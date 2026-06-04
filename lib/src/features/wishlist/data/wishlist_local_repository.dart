import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/models/wishlist_item_model.dart';

class WishlistLocalRepository {

  // OPEN USER SPECIFIC BOX
  Future<Box> _openBox(String uid,) async {
    final boxName = 'wishlist_$uid';
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    }
    return await Hive.openBox(boxName);
  }
  // CACHE WISHLIST
  Future<void> cacheWishlist(String uid, List<WishlistItemModel> items,) async {
    final box = await _openBox(uid);
    await box.clear();
    for (final item in items) {
      await box.put(
        item.productId,
        item.toMap(),
      );
    }
  }

  // GET CACHED WISHLIST
  Future<List<WishlistItemModel>> getCachedWishlist(String uid,) async {
    final box = await _openBox(uid);
    return box.values.map(
          (e) => WishlistItemModel.fromMap(
        Map<String, dynamic>.from(e),
      ),
    ).toList();
  }

  // CLEAR USER WISHLIST
  Future<void> clear(String uid,) async {
    final box = await _openBox(uid);
    await box.clear();
  }
}
