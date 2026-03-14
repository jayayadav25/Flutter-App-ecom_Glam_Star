import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/search_model.dart';

class SearchRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<SearchProductModel>> searchProducts(
      String query) async {
    if (query.isEmpty) return [];

    final snapshot = await _db
        .collection('products_light')
        .limit(20)
        .get();

    return snapshot.docs
        .map((doc) =>
        SearchProductModel.fromJson(doc.data()))
        .where((p) =>
    p.title.toLowerCase().contains(query) ||
        p.category.toLowerCase().contains(query) ||
        p.subCategory.toLowerCase().contains(query))
        .toList();
  }
}
