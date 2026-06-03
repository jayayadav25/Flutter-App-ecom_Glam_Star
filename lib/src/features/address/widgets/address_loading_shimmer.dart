import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class AddressLoadingShimmer extends ConsumerWidget {

  const AddressLoadingShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 4,
      itemBuilder: (_, __) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 16,
          ),

          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  24,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}