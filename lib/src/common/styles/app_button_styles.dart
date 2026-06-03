import 'package:flutter/material.dart';
import 'colors.dart';

class AppButtonStyles {

  // Primary Black Button
  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryBlack,
    foregroundColor: Colors.white,
    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600,),
    elevation: 0,
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 16,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
    ),
  );


  // Gold Premium Button
  static final ButtonStyle goldButton =
  ElevatedButton.styleFrom(
    backgroundColor: AppColors.softGold,
    foregroundColor: AppColors.primaryBlack,
    elevation: 0,
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 16,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  );

  static final ButtonStyle buyNowButton =
  ElevatedButton.styleFrom(
    backgroundColor: AppColors.softGold,
    foregroundColor: AppColors.primaryBlack,
    elevation: 0,
    padding: const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 10,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  );

  // Outline Button
  static final ButtonStyle outlineButton =
  OutlinedButton.styleFrom(
    foregroundColor: AppColors.primaryBlack,
    side: const BorderSide(
      color: AppColors.primaryBlack,
      width: 1.2,
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 16,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  );

  // Gold Text Button
  static final ButtonStyle goldTextButton =
  TextButton.styleFrom(
    foregroundColor: AppColors.softGold,
    textStyle: const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w600,
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 4,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  // Dark Text Button

  static final ButtonStyle darkTextButton =
  TextButton.styleFrom(
    foregroundColor: AppColors.primaryBlack,
    textStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 4,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  // Minimal Text Button
  static final ButtonStyle minimalTextButton =
  TextButton.styleFrom(
    foregroundColor: const Color(0xFF7A7A7A),

    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),

    padding: EdgeInsets.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}