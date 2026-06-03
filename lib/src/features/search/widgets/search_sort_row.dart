import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchSortRow extends ConsumerWidget {

  final String selected;
  final Function(String) onChanged;

  const SearchSortRow({ super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sorts = [
      "relevance",
      "price_low",
      "price_high",
    ];

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          final item = sorts[i];
          final active = selected == item;
          return ChoiceChip(
            label: Text(item),
            selected: active,
            onSelected: (_) => onChanged(item),
          );
        },

        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemCount: sorts.length,
      ),
    );
  }
}