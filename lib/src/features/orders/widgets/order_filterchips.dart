import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderFilterChips extends ConsumerWidget {
  final String selected;
  final Function(String) onSelected;

  const OrderFilterChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final filters = const [

    'All',
    'Placed',
    'Shipped',
    'Delivered',
    'Cancelled',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) {
          return const SizedBox(width: 10,);
        },
        itemBuilder: (_, index) {
          final filter = filters[index];
          final active = selected == filter;
          return GestureDetector(
            onTap: () {
              onSelected(filter,);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250,),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10,),
              decoration: BoxDecoration(
                color: active ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(30,),
              ),
              child: Text(filter,
                style: TextStyle(
                  color: active ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}