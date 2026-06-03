import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PremiumLoadingShimmer extends StatelessWidget {
  const PremiumLoadingShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .58,
        crossAxisSpacing: 10,
        mainAxisSpacing: 14,
      ),

      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        );
      },
    );
  }
}