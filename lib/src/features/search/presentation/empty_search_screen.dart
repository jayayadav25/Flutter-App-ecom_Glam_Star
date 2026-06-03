import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmptySearchScreen extends ConsumerWidget {
  final String query;

  const EmptySearchScreen({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            size: 90,
            color: Colors.grey,
          ),

          const SizedBox(height: 20),
          Text(
            "No results found for",
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),

          const SizedBox(height: 8),
          Text(query,
            style: const TextStyle(
              fontWeight:
              FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
