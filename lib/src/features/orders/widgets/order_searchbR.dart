import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderSearchBar extends ConsumerWidget {
  final Function(String) onChanged;

  const OrderSearchBar({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search Orders',
        prefixIcon: const Icon(Icons.search,),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20,),
          borderSide:
          BorderSide.none,
        ),
      ),
    );
  }
}