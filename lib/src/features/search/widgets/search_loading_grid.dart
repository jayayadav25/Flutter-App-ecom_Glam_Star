import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class SearchLoadingGrid extends ConsumerWidget {

  const SearchLoadingGrid({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return GridView.builder(
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .62,
      ),

      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(20),
            ),
          ),
        );
      },
    );
  }
}