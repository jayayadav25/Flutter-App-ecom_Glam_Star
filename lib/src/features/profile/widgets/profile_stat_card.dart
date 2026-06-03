import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileStatCard extends ConsumerWidget {
  final String title;
  final String value;

  const ProfileStatCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Container(
        height: 90,
        margin: const EdgeInsets.symmetric(
          horizontal: 6,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}