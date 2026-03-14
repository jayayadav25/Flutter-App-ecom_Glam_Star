import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/saved_for_later_provider.dart';

class SavedForLaterSection extends ConsumerWidget {
  const SavedForLaterSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedItems = ref.watch(savedForLaterProvider);

    if (savedItems.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Saved For Later",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...savedItems.map((p) => Card(
          child: ListTile(
            title: Text(p.title),
            subtitle: Text("₹${p.sellingPrice}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => ref
                  .read(savedForLaterProvider.notifier)
                  .remove(p.productId.toString()),
            ),
          ),
        )),
      ],
    );
  }
}
