import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_provider.dart';

class CategoryStrip extends ConsumerWidget {
  const CategoryStrip({super.key});

  static const categories = [
    'men',
    'women',
    'kids',
    'footwear',
    'accessories',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedCategoryProvider);

    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final cat = categories[i];
          final isSelected = selected == cat;

          return ChoiceChip(
            label: Text(cat.toUpperCase()),
            selected: isSelected,
            onSelected: (_) {
              ref.read(selectedCategoryProvider.notifier).state =
              isSelected ? null : cat;
            },
          );
        },
      ),
    );
  }
}
