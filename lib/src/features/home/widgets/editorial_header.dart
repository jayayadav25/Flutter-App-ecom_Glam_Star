import 'package:flutter/material.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import 'editorial_data.dart';

class EditorialHeader extends StatelessWidget {
  final EditorialData section;

  const EditorialHeader({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          Text(section.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.heading1.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 8),

          Container(
            width: 45,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.softGold,
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            section.subtitle,

            textAlign: TextAlign.center,

            style: AppTextStyles.caption1.copyWith(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}