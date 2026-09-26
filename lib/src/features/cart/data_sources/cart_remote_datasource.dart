import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/models/cart_item_model.dart';

class CartRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  CartRemoteDataSource({
    required this.firestore,
    required this.auth,
  });

  CollectionReference<Map<String, dynamic>>? get _cartRef {
    final user = auth.currentUser;

    if (user == null) return null;

    return firestore
        .collection('users')
        .doc(user.uid)
        .collection('cart');
  }

  /// Sync Cart To Firestore
  Future<void> syncCart(
      List<CartItemModel> items,
      ) async {
    final user = auth.currentUser;

    if (user == null) return;

    final cartRef = _cartRef;

    if (cartRef == null) return;

    final batch = firestore.batch();

    /// Remove old cart docs
    final existingDocs = await cartRef.get();

    for (final doc in existingDocs.docs) {
      batch.delete(doc.reference);
    }

    /// Add latest cart docs
    for (final item in items) {
      batch.set(
        cartRef.doc(item.productId),
        {
          ...item.toMap(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
      );
    }

    await batch.commit();

    /// Save last cart activity timestamp
    await firestore
        .collection('users')
        .doc(user.uid)
        .set(
      {
        'cartLastUpdated':
        FieldValue.serverTimestamp(),
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  /// Fetch Cart
  Future<List<CartItemModel>> fetchCart() async {
    final cartRef = _cartRef;

    if (cartRef == null) return [];

    final snapshot = await cartRef
        .orderBy(
      'updatedAt',
      descending: true,
    )
        .get();

    return snapshot.docs
        .map(
          (doc) => CartItemModel.fromMap(
        doc.data(),
      ),
    )
        .toList();
  }

  /// Remove Single Item
  Future<void> removeItem(
      String productId,
      ) async {
    final cartRef = _cartRef;

    if (cartRef == null) return;

    await cartRef
        .doc(productId)
        .delete();

    final user = auth.currentUser;

    if (user != null) {
      await firestore
          .collection('users')
          .doc(user.uid)
          .set(
        {
          'cartLastUpdated':
          FieldValue.serverTimestamp(),
        },
        SetOptions(
          merge: true,
        ),
      );
    }
  }

  /// Clear Entire Cart
  Future<void> clearCart() async {
    final cartRef = _cartRef;

    if (cartRef == null) return;

    final snapshot = await cartRef.get();

    final batch = firestore.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  /// Cart Count
  Future<int> getCartCount() async {
    final cartRef = _cartRef;

    if (cartRef == null) return 0;

    final snapshot = await cartRef.get();

    return snapshot.docs.length;
  }

  /// Check Cart Empty
  Future<bool> isCartEmpty() async {
    final count = await getCartCount();

    return count == 0;
  }
}










// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../../core/models/cart_item_model.dart';
//
// class CartRemoteDataSource {
//   final FirebaseFirestore firestore;
//   final FirebaseAuth auth;
//
//   CartRemoteDataSource({
//     required this.firestore,
//     required this.auth,
//   });
//
//   Future<void> syncCart(List<CartItemModel> items) async {
//     final user = auth.currentUser;
//     if (user == null) return;
//
//     final cartRef = firestore
//         .collection('users')
//         .doc(user.uid)
//         .collection('cart');
//
//     final batch = firestore.batch();
//
//     for (final item in items) {
//       batch.set(
//         cartRef.doc(item.productId),
//         {
//           ...item.toMap(),
//           'updatedAt': FieldValue.serverTimestamp(),
//         },
//       );
//     }
//
//     await batch.commit();
//     await firestore
//         .collection('users')
//         .doc(user.uid)
//         .set(
//       {
//         'cartLastUpdated':
//         FieldValue.serverTimestamp(),
//       },
//       SetOptions(
//         merge: true,
//       ),
//     );
//   }
//
//   // Future<void> syncCart(List<CartItemModel> items) async {
//   //   final user = auth.currentUser;
//   //   if (user == null) return;
//   //   final cartRef = firestore
//   //       .collection('users')
//   //       .doc(user.uid)
//   //       .collection('cart');
//   //
//   //   final batch = firestore.batch();
//   //   for (final item in items) {
//   //     batch.set(
//   //       cartRef.doc(item.productId),
//   //       item.toMap(),
//   //     );
//   //   }
//   //
//   //   await batch.commit();
//   // }
//
//   Future<List<CartItemModel>> fetchCart() async {
//     final user = auth.currentUser;
//     if (user == null) return [];
//     final snapshot = await firestore
//         .collection('users')
//         .doc(user.uid)
//         .collection('cart')
//         .get();
//
//     return snapshot.docs
//         .map((e) => CartItemModel.fromMap(e.data()))
//         .toList();
//   }
// }