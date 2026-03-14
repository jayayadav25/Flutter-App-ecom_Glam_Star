import 'package:firebase_mastery_app/src/features/search/presentation/search_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/search_history_provider.dart';
import '../provider/search_provider.dart';
import '../utils/debounce.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final controller = TextEditingController();
  final debouncer = Debouncer();

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(searchHistoryProvider);
    final trending = ref.watch(trendingSearchesProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Search products",
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.mic),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Voice search coming soon 🎤")),
                );
              },
            ),
          ),
          onChanged: (v) {
            debouncer.run(() {
              ref.read(searchQueryProvider.notifier).state = v;
            });
          },
          onSubmitted: (v) {
            ref.read(searchHistoryProvider.notifier).add(v);
          },
        ),
      ),
      body: controller.text.isEmpty
          ? ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (history.isNotEmpty) ...[
            const Text("Recent Searches",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...history.map((e) => ListTile(
              leading: const Icon(Icons.history),
              title: Text(e),
              onTap: () {
                controller.text = e;
                ref.read(searchQueryProvider.notifier).state = e;
              },
            )),
          ],
          const SizedBox(height: 16),
          const Text("Trending",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...trending.map((e) => ListTile(
            leading: const Icon(Icons.trending_up),
            title: Text(e),
            onTap: () {
              controller.text = e;
              ref.read(searchQueryProvider.notifier).state = e;
            },
          )),
        ],
      )
          : const SearchResultsScreen(),
    );
  }
}
