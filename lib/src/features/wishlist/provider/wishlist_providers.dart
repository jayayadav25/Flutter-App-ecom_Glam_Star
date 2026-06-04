import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/wishlist_item_model.dart';
import '../controllers/wishlist_controller.dart';
import '../data/wishlist_firestore_service.dart';
import '../data/wishlist_local_repository.dart';
import '../data/wishlist_remote_repository.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance,);

final firestoreProvider = Provider((ref) => FirebaseFirestore.instance,);

final wishlistFirestoreServiceProvider = Provider(
      (ref) => WishlistFirestoreService(
    ref.read(firestoreProvider),
  ),
);

final wishlistRemoteRepoProvider = Provider(
      (ref) => WishlistRemoteRepository(
    ref.read(firestoreProvider),
  ),
);

final wishlistLocalRepoProvider = Provider((ref) => WishlistLocalRepository(),);

final wishlistProvider = AsyncNotifierProvider.autoDispose
<WishlistController, List<WishlistItemModel>>(
  WishlistController.new,
);

final isWishlistedProvider = Provider.family<bool, int>((ref, productId) {
    final items = ref.watch(wishlistProvider).value ?? [];
    return items.any((e) => e.productId == productId,
    );
  },
);