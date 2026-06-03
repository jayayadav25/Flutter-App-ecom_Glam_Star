import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_mastery_app/src/common/styles/text_styles.dart';
import 'package:firebase_mastery_app/widgets/images.dart';
import 'package:flutter/material.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.shopping_bag,
              //width: 100,
            // height: 125,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 24),
            const Text(
              'Oops! Shopping bag Is Empty',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Time to treat yourself.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText1
            )
          ],
        ),
      ),
    );
  }
}
