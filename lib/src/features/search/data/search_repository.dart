import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/light_product_model.dart';
import '../utils/search_map.dart';
import '../widgets/search_normalizer.dart';

class SearchRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<LightProductModel>> searchProducts(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }
    final normalizedQuery = normalize(query);

    // Query words
    final words = normalizedQuery.split(' ');

    // Expanded search
    final Set<String> searchTerms = {};
    for (final word in words) {
      searchTerms.add(word);

      // Aliases

      for (final entry in subcategoryAliases.entries) {
        if (entry.key == word || entry.value.contains(word)) {
          searchTerms.add(entry.key);
          searchTerms.addAll(
            entry.value,
          );
        }
      }

      // Singular

      if (word.endsWith('s')) {
        searchTerms.add(
          word.substring(0, word.length - 1,),
        );
      }

      // Plural
      searchTerms.add('${word}s');
    }

    final List<LightProductModel>allResults = [];

    // Search each term
    for (final term in searchTerms) {
      // Category Query
      final categorySnapshot = await _db
          .collection('products_light')
          .where(
        'category',
        isEqualTo: term,
      ).limit(50).get();

      // SubCategory Query

      final subCategorySnapshot = await _db.collection('products_light')
          .where(
        'sub_category',
        isEqualTo: term,
      ).limit(50).get();

      // Title Prefix Query
      final titleSnapshot = await _db
          .collection('products_light')
          .orderBy('title')
          .startAt([term])
          .endAt(['$term\uf8ff'])
          .limit(50)
          .get();

      // Merger results

      final docs = [
        ...categorySnapshot.docs,
        ...subCategorySnapshot.docs,
        ...titleSnapshot.docs,
      ];

      for (final doc in docs) {
        try {
          allResults.add(
            LightProductModel.fromJson(
              doc.data(),
            ),
          );
        } catch (_) {}
      }
    }

    // Remove Duplicates
    final seen = <int>{};
    final results = allResults.where((product) {
      if (seen.contains(product.productId)) {
        return false;
      }
      seen.add(product.productId);
      return true;
    }).toList();
    return results;
  }
}
