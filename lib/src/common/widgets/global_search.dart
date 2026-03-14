import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../features/search/presentation/search_filter_screen.dart';
import '../../features/search/provider/search_provider.dart';
import '../../features/search/presentation/search_screen.dart';
import '../../features/search/presentation/search_suggestion_screen.dart';
import '../../features/search/presentation/voice_search_screen.dart';

class GlobalSearchBar extends ConsumerStatefulWidget {
  const GlobalSearchBar({super.key});

  @override
  ConsumerState<GlobalSearchBar> createState() => _GlobalSearchBarState();
}

class _GlobalSearchBarState extends ConsumerState<GlobalSearchBar>
    with SingleTickerProviderStateMixin {
  late stt.SpeechToText _speech;
  bool isListening = false;
  String voiceQuery = "";

  late AnimationController _micController;
  late Animation<double> _micAnimation;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();

    _micController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _micAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _micController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _micController.dispose();
    super.dispose();
  }

  Future<void> _startListening() async {
    bool available = await _speech.initialize();
    if (!available) return;

    setState(() => isListening = true);
    _micController.repeat(reverse: true);

    _speech.listen(
      onResult: (result) {
        final text = result.recognizedWords;

        // Update query in provider
        ref.read(searchQueryProvider.notifier).state = text;

        // Add to history
       // ref.read(searchHistoryProvider.notifier).add(text);

        // Immediately open search screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SearchScreen()),
        );
      },
    );
  }

  void _stopListening() {
    _speech.stop();
    _micController.stop();
    setState(() => isListening = false);
  }

  void _openSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SearchScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            // Search icon
            const Icon(Icons.search, color: Colors.black54),

            const SizedBox(width: 12),

            // Text
            Expanded(
              child: GestureDetector(
                onTap: _openSearch,
                child: Hero(
                  tag: "search_bar",
                  child: Container(
                    color: Colors.transparent,
                    child: const Text(
                      "Search products...",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 6),

            // Suggestions button
            // IconButton(
            //   icon: const Icon(Icons.lightbulb_outline, color: Colors.orange),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (_) => const SearchSuggestionScreen()),
            //     );
            //   },
            // ),

            //Filters button
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.blueAccent),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchFiltersScreen()),
                );
              },
            ),

            // Voice Search button
            GestureDetector(
              onTap: () {
                if (isListening) {
                  _stopListening();
                } else {
                  _startListening();
                }
              },
              onLongPress: () {
                //Full voice search screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VoiceSearchScreen()),
                );
              },
              child: ScaleTransition(
                scale: _micAnimation,
                child: Icon(
                  isListening ? Icons.mic : Icons.mic_none,
                  size: 26,
                  color: isListening ? Colors.red : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
