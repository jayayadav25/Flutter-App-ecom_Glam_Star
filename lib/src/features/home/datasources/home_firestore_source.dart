import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/product_model.dart';
class HomeFirestoreSource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<List<ProductModel>> fetchLatest(int limit) async {
    final snap = await _db.collection('products')
        .orderBy('createdAt', descending: true,)
        .limit(limit).get();

    return snap.docs.map(
          (e) => ProductModel.fromJson(e.data()),
    ).toList();
  }

  Future<List<ProductModel>> fetchByCategory(String category) async {
    final snap = await _db
        .collection('products')
        .where('category',
      isEqualTo: category,
    ).limit(20).get();
    return snap.docs.map(
          (e) => ProductModel.fromJson(e.data()),
    ).toList();
  }
}
