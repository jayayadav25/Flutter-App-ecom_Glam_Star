

 import 'package:flutter/material.dart';

import 'colors.dart';

 class AppTextStyles {

   // DISPLAY
  static const TextStyle displayLarge = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

   // Headings
   static const TextStyle title = TextStyle(
     fontSize: 32,
     fontWeight: FontWeight.bold,
     color: AppColors.titleText,
     letterSpacing: 1,
   );

   static const TextStyle heading1 = TextStyle(
     fontSize: 26,
     fontWeight: FontWeight.bold,
     color: AppColors.titleText,
   );

   static const TextStyle heading2 = TextStyle(
     fontSize: 22,
     fontWeight: FontWeight.w600,
     color: AppColors.titleText,
   );

   static const TextStyle sectionTitle = TextStyle(
     fontSize: 18,
     fontWeight: FontWeight.w600,
     color: AppColors.titleText,
   );

    // TITLES
  static const TextStyle titleLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.titleText,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.titleText,
  );

  static const TextStyle smallTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.primaryBlack,
    height: 1.5,
  );

   // Product Text
  static const TextStyle productBrand = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.softGold,
  );

   static const TextStyle productTitle = TextStyle(
     fontSize: 15,
     fontWeight: FontWeight.w600,
     color: AppColors.titleText,
   );

  static const TextStyle productPrice = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.titleText,
  );

   static const TextStyle oldPrice = TextStyle(
     fontSize: 14,
     decoration: TextDecoration.lineThrough,
     color: AppColors.subtitleText,
   );

  static const TextStyle discountPrice = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.success,
  );

   // Body & Description
   static const TextStyle bodyText = TextStyle(
     fontSize: 15,
     fontWeight: FontWeight.w800,
     color: AppColors.softGold,
     height: 1.5,
   );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.bodyText,
    height: 1.5,
  );

   static const TextStyle description = TextStyle(
     fontSize: 14,
     fontWeight: FontWeight.w500,
     color: AppColors.subtitleText,
     height: 1.7,
   );

   static const TextStyle caption = TextStyle(
     fontSize: 12,
     color: AppColors.whiteText,
   );

  static const TextStyle caption1 = TextStyle(
    fontSize: 12,
    color: AppColors.subtitleText,
  );



   // Buttons
   static const TextStyle buttonText = TextStyle(
     fontSize: 16,
     fontWeight: FontWeight.w600,
     color: AppColors.whiteText,
   );

   static const TextStyle goldButtonText = TextStyle(
     fontSize: 16,
     fontWeight: FontWeight.w600,
     color: AppColors.softGold,
   );
 static const TextStyle blackButtonText = TextStyle(
   fontSize: 16,
   fontWeight: FontWeight.w600,
   color: AppColors.primaryBlack,
 );
 }
