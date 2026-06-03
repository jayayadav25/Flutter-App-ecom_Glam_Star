import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/wishlist_item_model.dart';
import '../provider/wishlist_providers.dart';

class WishlistController
    extends AutoDisposeAsyncNotifier<
        List<WishlistItemModel>> {

  @override
  Future<List<WishlistItemModel>> build() async {

    final user = ref
        .read(firebaseAuthProvider)
        .currentUser;

    /// USER NOT LOGGED IN
    if (user == null) {
      return [];
    }

    final uid = user.uid;

    try {

      /// FETCH FROM FIRESTORE
      final remoteItems = await ref
          .read(wishlistRemoteRepoProvider)
          .getWishlist(uid);

      /// CACHE USER WISHLIST
      await ref
          .read(wishlistLocalRepoProvider)
          .cacheWishlist(
        uid,
        remoteItems,
      );

      return remoteItems;

    } catch (e) {

      /// FALLBACK TO LOCAL CACHE
      return await ref
          .read(wishlistLocalRepoProvider)
          .getCachedWishlist(uid);
    }
  }

  /// TOGGLE WISHLIST
  Future<void> toggleWishlist({
    required WishlistItemModel item,
  }) async {

    final user = ref
        .read(firebaseAuthProvider)
        .currentUser;

    if (user == null) return;

    final uid = user.uid;

    final currentItems =
        state.value ?? [];

    final alreadyExists =
    currentItems.any(
          (e) =>
      e.productId ==
          item.productId,
    );

    try {

      state = const AsyncLoading();

      /// REMOVE
      if (alreadyExists) {

        await ref
            .read(
          wishlistRemoteRepoProvider,
        )
            .removeFromWishlist(
          uid: uid,
          productId: item.productId,
        );

      }

      /// ADD
      else {

        await ref
            .read(
          wishlistRemoteRepoProvider,
        )
            .addToWishlist(
          uid: uid,
          item: item,
        );
      }

      /// REFRESH FROM FIRESTORE
      final updatedItems = await ref
          .read(
        wishlistRemoteRepoProvider,
      )
          .getWishlist(uid);

      /// UPDATE CACHE
      await ref
          .read(
        wishlistLocalRepoProvider,
      )
          .cacheWishlist(
        uid,
        updatedItems,
      );

      /// UPDATE UI
      state = AsyncData(updatedItems);

    } catch (e, st) {

      state = AsyncError(e, st);
    }
  }

  /// CLEAR USER WISHLIST
  Future<void> clearWishlist() async {

    final user = ref
        .read(firebaseAuthProvider)
        .currentUser;

    if (user == null) return;

    final uid = user.uid;

    /// CLEAR LOCAL CACHE
    await ref
        .read(wishlistLocalRepoProvider)
        .clear(uid);

    /// RESET STATE
    state = const AsyncData([]);
  }

  /// FORCE REFRESH
  Future<void> refreshWishlist() async {

    final user = ref
        .read(firebaseAuthProvider)
        .currentUser;

    if (user == null) {
      state = const AsyncData([]);
      return;
    }

    final uid = user.uid;

    try {

      state = const AsyncLoading();

      final remoteItems = await ref
          .read(
        wishlistRemoteRepoProvider,
      )
          .getWishlist(uid);

      await ref
          .read(
        wishlistLocalRepoProvider,
      )
          .cacheWishlist(
        uid,
        remoteItems,
      );

      state = AsyncData(remoteItems);

    } catch (e, st) {

      state = AsyncError(e, st);
    }
  }
}










// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../core/models/wishlist_item_model.dart';
// import '../provider/wishlist_providers.dart';
//
// class WishlistController extends AsyncNotifier<List<WishlistItemModel>> {
//
//   @override
//   Future<List<WishlistItemModel>> build() async {
//
//     final user = ref
//         .read(firebaseAuthProvider)
//         .currentUser;
//
//     if (user == null) {
//       return [];
//     }
//
//     final uid = user.uid;
//
//     try {
//
//       /// FIRESTORE
//       final remoteItems = await ref
//           .read(wishlistRemoteRepoProvider)
//           .getWishlist(uid);
//
//       /// CACHE
//       await ref
//           .read(wishlistLocalRepoProvider)
//           .cacheWishlist(
//         uid,
//         remoteItems,
//       );
//
//       return remoteItems;
//
//     } catch (e) {
//
//       /// LOCAL CACHE
//       return await ref
//           .read(wishlistLocalRepoProvider)
//           .getCachedWishlist(uid);
//     }
//   }
//
//   /// TOGGLE
//   Future<void> toggleWishlist({
//     required WishlistItemModel item,
//   }) async {
//
//     final user = ref
//         .read(firebaseAuthProvider)
//         .currentUser;
//
//     if (user == null) return;
//
//     final uid = user.uid;
//
//     final current =
//         state.value ?? [];
//
//     final exists = current.any(
//           (e) =>
//       e.productId ==
//           item.productId,
//     );
//
//     if (exists) {
//
//       await ref
//           .read(wishlistRemoteRepoProvider)
//           .removeFromWishlist(
//         uid: uid,
//         productId: item.productId,
//       );
//
//     } else {
//
//       await ref
//           .read(wishlistRemoteRepoProvider)
//           .addToWishlist(
//         uid: uid,
//         item: item,
//       );
//     }
//
//     /// REFRESH
//     final updated = await ref
//         .read(wishlistRemoteRepoProvider)
//         .getWishlist(uid);
//
//     /// CACHE UPDATED
//     await ref
//         .read(wishlistLocalRepoProvider)
//         .cacheWishlist(
//       uid,
//       updated,
//     );
//
//     state = AsyncData(updated);
//   }
//
//   /// CLEAR
//   Future<void> clearWishlist() async {
//
//     final user = ref
//         .read(firebaseAuthProvider)
//         .currentUser;
//
//     if (user == null) return;
//
//     await ref
//         .read(wishlistLocalRepoProvider)
//         .clear(user.uid);
//
//     state = const AsyncData([]);
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import '../../../core/models/wishlist_item_model.dart';
// // import '../provider/wishlist_providers.dart';
// //
// //
// // class WishlistController
// //     extends AsyncNotifier<
// //         List<WishlistItemModel>> {
// //
// //   @override
// //   Future<List<WishlistItemModel>>
// //   build() async {
// //
// //     final uid = ref
// //         .read(firebaseAuthProvider)
// //         .currentUser!
// //         .uid;
// //
// //     final remoteItems = await ref
// //         .read(wishlistRemoteRepoProvider)
// //         .getWishlist(uid);
// //
// //     await ref
// //         .read(wishlistLocalRepoProvider)
// //         .cacheWishlist(remoteItems);
// //
// //     return remoteItems;
// //   }
// //
// //   Future<void> toggleWishlist({
// //     required WishlistItemModel item,
// //   }) async {
// //
// //     final uid = ref
// //         .read(firebaseAuthProvider)
// //         .currentUser!
// //         .uid;
// //
// //     final current = state.value ?? [];
// //
// //     final exists = current.any(
// //           (e) =>
// //       e.productId ==
// //           item.productId,
// //     );
// //
// //     if (exists) {
// //
// //       await ref
// //           .read(
// //         wishlistRemoteRepoProvider,
// //       )
// //           .removeFromWishlist(
// //         uid: uid,
// //         productId: item.productId,
// //       );
// //
// //     } else {
// //
// //       await ref
// //           .read(
// //         wishlistRemoteRepoProvider,
// //       )
// //           .addToWishlist(
// //         uid: uid,
// //         item: item,
// //       );
// //     }
// //
// //     final updated = await ref
// //         .read(wishlistRemoteRepoProvider)
// //         .getWishlist(uid);
// //
// //     await ref
// //         .read(wishlistLocalRepoProvider)
// //         .cacheWishlist(updated);
// //
// //     state = AsyncData(updated);
// //   }
// // }