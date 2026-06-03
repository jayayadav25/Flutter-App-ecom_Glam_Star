import 'package:flutter/material.dart';

class WishlistLoadingGrid
    extends StatelessWidget {

  const WishlistLoadingGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return GridView.builder(

      padding:
      const EdgeInsets.all(16),

      itemCount: 6,

      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.62,
      ),

      itemBuilder: (_, index) {

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(24),
          ),
        );
      },
    );
  }
}