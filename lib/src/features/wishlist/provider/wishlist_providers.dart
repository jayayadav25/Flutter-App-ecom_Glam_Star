import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/wishlist_item_model.dart';
import '../controllers/wishlist_controller.dart';
import '../data/wishlist_firestore_service.dart';
import '../data/wishlist_local_repository.dart';
import '../data/wishlist_remote_repository.dart';

final firebaseAuthProvider =
Provider(
      (ref) => FirebaseAuth.instance,
);

final firestoreProvider =
Provider(
      (ref) => FirebaseFirestore.instance,
);

final wishlistFirestoreServiceProvider =
Provider(
      (ref) => WishlistFirestoreService(
    ref.read(firestoreProvider),
  ),
);

final wishlistRemoteRepoProvider =
Provider(
      (ref) => WishlistRemoteRepository(
    ref.read(firestoreProvider),
  ),
);

final wishlistLocalRepoProvider =
Provider(
      (ref) => WishlistLocalRepository(),
);

final wishlistProvider =
AsyncNotifierProvider.autoDispose<
    WishlistController,
    List<WishlistItemModel>>(
  WishlistController.new,
);

final isWishlistedProvider =
Provider.family<bool, int>(
      (ref, productId) {

    final items = ref
        .watch(wishlistProvider)
        .value ??
        [];

    return items.any(
          (e) =>
      e.productId ==
          productId,
    );
  },
);









// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../core/models/product_model.dart';
// import '../data/wishlist_repository.dart';
//
// class WishlistNotifier extends AsyncNotifier<List<ProductModel>> {
//   late WishlistRepository _repo;
//
//   @override
//   Future<List<ProductModel>> build() async {
//     _repo = WishlistRepository();
//     await _repo.init();
//
//     final items = _repo.getAll();
//     _cleanInvalidItems(items);
//
//     return _repo.getAll();
//   }
//
//   void toggle(ProductModel product) async {
//     await _repo.toggle(product);
//     state = AsyncData(_repo.getAll());
//   }
//
//   void remove(String productId) async {
//     await _repo.remove(productId);
//     state = AsyncData(_repo.getAll());
//   }
//
//   //  Clean corrupted items
//   void _cleanInvalidItems(List<ProductModel> items) async {
//     for (final p in items) {
//       if (p.productId > 0 ||
//           p.sellingPrice <= 0 ||
//           p.images.isEmpty) {
//         await _repo.remove(p.productId.toString());
//       }
//     }
//   }
// }
//
// final wishlistProvider =
// AsyncNotifierProvider<WishlistNotifier, List<ProductModel>>(
//   WishlistNotifier.new,
// );
//
// //  Check helper
// final isWishlistedProvider =
// Provider.family<bool, int>((ref, productId) {
//   final wishlist = ref.watch(wishlistProvider).value ?? [];
//   return wishlist.any((p) => p.productId == productId);
// });
//
