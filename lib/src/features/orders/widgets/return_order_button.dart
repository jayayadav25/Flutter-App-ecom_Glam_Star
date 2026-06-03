import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReturnOrderButton extends ConsumerWidget {

  const ReturnOrderButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16,),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16,),
          ),
        ),
        onPressed: () {
          // Return Flow
        },
        icon:
        const Icon(Icons.assignment_return,),
        label: const Text('Return Order',),
      ),
    );
  }
}