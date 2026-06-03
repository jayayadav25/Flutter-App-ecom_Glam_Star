import 'package:flutter/material.dart';
import '../../../common/styles/text_styles.dart';

class PremiumEmptyState extends StatelessWidget {

  final String title;
  final String subtitle;
  final IconData icon;

  const PremiumEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
              size: 70,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),

            Text(title,
              textAlign: TextAlign.center,
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 10),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.caption1,
            ),
          ],
        ),
      ),
    );
  }
}