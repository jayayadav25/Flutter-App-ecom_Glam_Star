import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultAddressBadge extends ConsumerWidget {

  const DefaultAddressBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),

      child: const Text("DEFAULT",
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight:
          FontWeight.w600,
        ),
      ),
    );
  }
}