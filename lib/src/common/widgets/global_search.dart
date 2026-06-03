
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../features/search/presentation/search_screen.dart';

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
          ],
        ),
      ),
    );
  }
}
