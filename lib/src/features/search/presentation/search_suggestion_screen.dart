// // lib/src/features/search/presentation/search_suggestion_screen.dart
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../provider/search_provider.dart';
//
// class SearchSuggestionScreen extends ConsumerWidget {
//   const SearchSuggestionScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     //final history = ref.watch(searchHistoryProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Suggestions"),
//       ),
//       body: history.isEmpty
//           ? const Center(child: Text("No suggestions available"))
//           : ListView(
//         children: history.reversed.map((item) {
//           return ListTile(
//             leading: const Icon(Icons.search),
//             title: Text(item),
//             onTap: () {
//               ref.read(searchQueryProvider.notifier).state = item;
//               Navigator.pop(context);
//             },
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
