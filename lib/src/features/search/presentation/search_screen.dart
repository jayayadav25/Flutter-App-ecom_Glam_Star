
import 'package:firebase_mastery_app/src/features/search/presentation/search_result_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/styles/colors.dart';
import '../provider/search_history_provider.dart';
import '../provider/search_provider.dart';
import '../widgets/debounce.dart';
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key,});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {

  final controller = TextEditingController();
  final debouncer = Debounce();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    controller.clear();
    controller.dispose();
    debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(searchHistoryProvider);
    final trending = ref.watch(trendingSearchesProvider);
    final query = ref.watch(searchQueryProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffold,
        appBar: AppBar(
        backgroundColor: AppColors.scaffold,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,

        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: Colors.black,
            ),
            onPressed: () {
              controller.clear();

              if (mounted) {
                ref.invalidate(searchQueryProvider);
              }


              Navigator.pop(context);
            },
          ),
        ),

        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16,),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],

              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),

            child: Row(
              children: [
                // Search Icon
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Icon(
                    Icons.search_rounded,
                    color: Colors.grey.shade500,
                    size: 24,
                  ),
                ),

                const SizedBox(width: 12),

                // TextField
                Expanded(
                  child: TextField(
                    controller: controller,
                    autofocus: true,

                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),

                    decoration: InputDecoration(
                      hintText: "Search luxury fashion...",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),

                      border: InputBorder.none,

                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),

                      // Mic Icon
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          // Show cross only when text exists
                          if (controller.text.isNotEmpty)
                            IconButton(
                              icon: const Icon(
                                Icons.close_rounded,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                controller.clear();

                                if (!mounted) return;

                                ref.invalidate(searchQueryProvider);
                              },
                            ),

                          IconButton(
                            icon: Icon(
                              Icons.mic_rounded,
                              color:Colors.grey.shade500,
                              size: 22,
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Voice search coming soon 🎤",
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      // suffixIcon: IconButton(
                      //   icon: Icon(
                      //     Icons.mic_rounded,
                      //     color: AppColors.softGold,
                      //     size: 22,
                      //   ),
                      //   onPressed: () {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //         content: Text(
                      //           "Voice search coming soon 🎤",
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
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
              ],
            ),
          ),
        ),
      ),

      body: query.isEmpty ? ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (history.isNotEmpty)
            const Text("Recent Searches",),
          ...history.map((item) {
            return ListTile(
              leading: const Icon(Icons.history),
              title: Text(item),
              onTap: () {
                debugPrint("recent Tapped: $item");

                if (!mounted) return;

                controller.text = item;

                ref.read(searchQueryProvider.notifier).state = item;
                // controller.text = item;
                // ref.read(searchQueryProvider.notifier,)
                //     .state = item;
              },
            );
          }),

          const SizedBox(height: 20),

          const Text("Trending Searches",),
          ...trending.map((item) {
            return ListTile(
              leading: const Icon(Icons.trending_up),
              title: Text(item),
              onTap: () {
                debugPrint("trending Tapped: $item");

                if (!mounted) return;

                controller.text = item;

                ref.read(searchQueryProvider.notifier).state = item;
                // controller.text = item;
                // ref.read(searchQueryProvider.notifier,
                // ).state = item;
              },
            );
          }),
        ],
      ) : const SearchResultsScreen(),
    );
  }
}
