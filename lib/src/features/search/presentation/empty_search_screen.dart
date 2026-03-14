import 'package:flutter/material.dart';

class EmptySearchScreen extends StatelessWidget {
  final String query;

  const EmptySearchScreen({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 80, color: Colors.grey),
            const SizedBox(height: 20),
            Text("No results for '$query'", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            const Text("Try a different keyword", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}