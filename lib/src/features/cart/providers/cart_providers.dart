import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/cart_item_model.dart';
import '../data/cart_repository_impl.dart';
import '../data_sources/cart_local_datasources.dart';
import '../data_sources/cart_remote_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// LOCAL DATASOURCE
final cartLocalDataSourceProvider = Provider<CartLocalDataSource>((ref) {
  return CartLocalDataSource();
});

/// REMOTE DATASOURCE
final cartRemoteDataSourceProvider = Provider<CartRemoteDataSource>((ref) {
  return CartRemoteDataSource(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

/// REPOSITORY
final cartRepositoryProvider = Provider<CartRepositoryImpl>((ref) {
  return CartRepositoryImpl(
    local: ref.read(cartLocalDataSourceProvider),
    remote: ref.read(cartRemoteDataSourceProvider),
  );
});

class CartNotifier extends AsyncNotifier<List<CartItemModel>> {
  CartRepositoryImpl get repository =>
      ref.read(cartRepositoryProvider);

  @override
  Future<List<CartItemModel>> build() async {
    return await repository.getCart();
  }

  Future<void> addToCart(CartItemModel item) async {
    try {
      final currentItems = state.value ?? [];

      // Optimistic update
      state = AsyncData([
        ...currentItems,
        item,
      ]);

      await repository.addToCart(item);

      state = AsyncData(
        await repository.getCart(),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> removeFromCart(String productId) async {
    try {
      await repository.removeFromCart(productId);

      state = AsyncData(
        await repository.getCart(),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> increment(String productId) async {
    try {
      await repository.increment(productId);

      state = AsyncData(
        await repository.getCart(),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> decrement(String productId) async {
    try {
      await repository.decrement(productId);

      state = AsyncData(
        await repository.getCart(),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> clearCart() async {
    try {
      await repository.clearCart();

      state = const AsyncData([]);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final cartProvider =
AsyncNotifierProvider<CartNotifier, List<CartItemModel>>(
  CartNotifier.new,
);













// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../core/models/cart_item_model.dart';
// import '../data/cart_repository_impl.dart';
// import '../data_sources/cart_local_datasources.dart';
// import '../data_sources/cart_remote_datasource.dart';
//
// // LOCAL DATASOURCE
// final cartLocalDataSourceProvider = Provider<CartLocalDataSource>((ref) {
//   return CartLocalDataSource();
// });
//
// // REMOTE DATASOURCE
// final cartRemoteDataSourceProvider = Provider<CartRemoteDataSource>((ref) {
//   return CartRemoteDataSource(
//     firestore: FirebaseFirestore.instance,
//     auth: FirebaseAuth.instance,
//   );
// });
//
// // REPOSITORY
// final cartRepositoryProvider = Provider<CartRepositoryImpl>((ref) {
//   return CartRepositoryImpl(
//     local: ref.read(cartLocalDataSourceProvider),
//     remote: ref.read(cartRemoteDataSourceProvider),
//   );
// });
//
// class CartNotifier extends AsyncNotifier<List<CartItemModel>> {
//   late final CartRepositoryImpl repository;
//
//   @override
//   Future<List<CartItemModel>> build() async {
//     repository = ref.read(
//       cartRepositoryProvider,
//     );
//     return repository.getCart();
//   }
//
//   Future<void> addToCart(CartItemModel item) async {
//     try {
//       final currentItems = state.value ?? [];
//       // OPTIMISTIC UPDATE
//       state = AsyncData([
//         ...currentItems,
//         item,
//       ]);
//       await repository.addToCart(item);
//       final updated = await repository.getCart();
//       state = AsyncData(updated);
//     } catch (e, st) {
//       state = AsyncError(e, st);
//     }
//   }
//
//   Future<void> removeFromCart(String productId) async {
//     try {
//       await repository.removeFromCart(productId);
//       final updated = await repository.getCart();
//       state = AsyncData(updated);
//     } catch (e, st) {
//       state = AsyncError(e, st);
//     }
//   }
//
//   Future<void> increment(String productId) async {
//     try {
//       await repository.increment(productId);
//       final updated = await repository.getCart();
//       state = AsyncData(updated);
//     } catch (e, st) {
//       state = AsyncError(e, st);
//     }
//   }
//
//   Future<void> decrement(String productId) async {
//     try {
//       await repository.decrement(productId);
//       final updated = await repository.getCart();
//       state = AsyncData(updated);
//     } catch (e, st) {
//       state = AsyncError(e, st);
//     }
//   }
//
//   Future<void> clearCart() async {
//     try {
//       await repository.clearCart();
//       state = const AsyncData([]);
//     } catch (e, st) {
//       state = AsyncError(e, st);
//     }
//   }
// }
//
// final cartProvider = AsyncNotifierProvider<CartNotifier, List<CartItemModel>>(
//   CartNotifier.new,
// );