import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileSectionTitle extends ConsumerWidget {

  final String title;

  const ProfileSectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Text(title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight:
        FontWeight.bold,
      ),
    );
  }
}