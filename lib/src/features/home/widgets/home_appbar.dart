import 'package:flutter/material.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 18,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('GLAMSTAR',
                style: AppTextStyles.title.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 4),
              Text('Luxury Fashion Store',
                style: AppTextStyles.caption1,
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                  color: Colors.black.withOpacity(.06),
                ),
              ],
            ),

            child: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.primaryBlack,
            ),
          ),
        ],
      ),
    );
  }
}