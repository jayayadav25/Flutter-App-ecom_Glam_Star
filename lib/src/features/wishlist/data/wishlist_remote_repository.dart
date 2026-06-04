import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/wishlist_item_model.dart';

class WishlistRemoteRepository {
  final FirebaseFirestore firestore;

  WishlistRemoteRepository(this.firestore,);

  CollectionReference<Map<String, dynamic>> _wishlistRef(String uid) {
    return firestore.collection('users').doc(uid).collection('wishlist');
  }

  Future<List<WishlistItemModel>> getWishlist(String uid) async {
    final snap = await _wishlistRef(uid).orderBy(
      'addedAt',
      descending: true,
    ).get();
    return snap.docs.map(
          (doc) => WishlistItemModel
          .fromMap(doc.data()),
    ).toList();
  }

  Future<void> addToWishlist({
    required String uid,
    required WishlistItemModel item,}) async {
    await _wishlistRef(uid).doc(item.productId.toString()).set(item.toMap());
  }

  Future<void> removeFromWishlist({
    required String uid,
    required int productId,}) async {
    await _wishlistRef(uid).doc(productId.toString()).delete();
  }

  Future<bool> isWishlisted({
    required String uid,
    required int productId,
  }) async {

    final doc = await _wishlistRef(uid).doc(productId.toString()).get();
    return doc.exists;
  }
}