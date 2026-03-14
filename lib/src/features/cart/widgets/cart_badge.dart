import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_providers.dart';


class BottomCartIcon extends ConsumerWidget {
  final bool isSelected;

  const BottomCartIcon({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(cartCountProvider);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          Icons.shopping_bag_outlined,
          color: isSelected ? Colors.black : Colors.grey,
        ),

        if (count > 0)
          Positioned(
            right: -6,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Center(
                child: Text(
                  count > 9 ? "9+" : count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
