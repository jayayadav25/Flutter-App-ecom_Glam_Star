// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../provider/search_filter_provider.dart';
//
//
// class SearchSortSheet extends ConsumerWidget {
//   const SearchSortSheet({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final current = ref.watch(sortTypeProvider);
//
//     Widget tile(String title, SortType type) {
//       return RadioListTile(
//         value: type,
//         groupValue: current,
//         onChanged: (v) {
//           ref.read(sortTypeProvider.notifier).state = v!;
//           Navigator.pop(context);
//         },
//         title: Text(title),
//       );
//     }
//
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         tile("Relevance", SortType.relevance),
//         tile("Price: Low to High", SortType.priceLowHigh),
//         tile("Price: High to Low", SortType.priceHighLow),
//         tile("Rating", SortType.rating),
//       ],
//     );
//   }
// }
