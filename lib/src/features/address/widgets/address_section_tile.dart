import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressSectionTitle extends ConsumerWidget {
  final String title;

  const AddressSectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),

      child: Text(title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight:
          FontWeight.bold,
        ),
      ),
    );
  }
}