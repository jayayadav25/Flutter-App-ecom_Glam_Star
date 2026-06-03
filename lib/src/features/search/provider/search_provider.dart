import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/light_product_model.dart';
import '../widgets/search_normalizer.dart';
import 'all_products_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider =
Provider<AsyncValue<List<LightProductModel>>>((ref) {
  final query = normalize(ref.watch(searchQueryProvider));

  final allProductsAsync = ref.watch(allProductsProvider);

  return allProductsAsync.whenData((products) {
    if (query.isEmpty) return [];

    final queryWords = query.split(' ');

    return products.where((product) {
      final searchableText = normalize('''
${product.title}
${product.category}
${product.subCategory}
${product.slug}
''');

      return queryWords.every(
            (word) =>
        searchableText.contains(word) ||
            searchableText.contains('${word}s') ||
            searchableText.contains(
              word.endsWith('s')
                  ? word.substring(0, word.length - 1)
                  : word,
            ),
      );
    }).toList();
  });
});









// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../core/models/light_product_model.dart';
// import '../widgets/search_normalizer.dart';
// import 'all_products_provider.dart';
//
// final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');
// //final searchQueryProvider = StateProvider<String>((_) => '');
//
// final searchResultsProvider = Provider<AsyncValue<List<LightProductModel>>>((ref,) {
//   final query = normalize(ref.watch(searchQueryProvider),);
//   final allProductsAsync = ref.watch(allProductsProvider);
//   return allProductsAsync.whenData((products) {
//
//     // Empty Query
//
//     if (query.isEmpty) {
//       return [];
//     }
//
//     final queryWords = query.split(' ');
//     final results = products.where((product) {
//       final searchableText = normalize('''
//       ${product.title}
//       ${product.category}
//       ${product.subCategory}
//       ${product.slug}
//       ''');
//
//       // Token Match
//       return queryWords.every((word) =>
//         searchableText.contains(word) || searchableText.contains(
//               '${word}s',
//             ) || searchableText.contains(
//               word.endsWith('s')
//                   ? word.substring(0, word.length - 1,) : word,
//             ),
//       );
//
//     }).toList();
//     return results;
//   });
// });
