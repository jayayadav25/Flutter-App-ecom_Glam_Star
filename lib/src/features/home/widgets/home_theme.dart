import 'dart:ui';
import '../../../common/styles/colors.dart';
import '../providers/home_provider.dart';
import 'home_theme_config.dart';

class HomeThemes {
  static HomeThemeConfig getTheme(HomeTab tab) {
    switch (tab) {
      case HomeTab.women:
        return HomeThemeConfig(
          gradients: [
            Color(0xFFFFE5EC),
            Color(0xFFFFCAD4),
          ],
          textColor: AppColors.primaryBlack,
          chipColor: Color(0xFFFF8FAB),
        );

      case HomeTab.men:
        return const HomeThemeConfig(
          gradients: [
            Color(0xFFEAF4FF),
            Color(0xFFD6E8FF),
          ],
          textColor: AppColors.primaryBlack,
          chipColor: Color(0xFF90CAF9),
        );

      case HomeTab.kids:
        return const HomeThemeConfig(
          gradients: [
            Color(0xFFFFF4D6),
            Color(0xFFFFE9A8),
          ],
          textColor: AppColors.primaryBlack,
          chipColor: Color(0xFFFFD54F),
        );

      case HomeTab.home:
      default:
        return const HomeThemeConfig(
          gradients: [
            Color(0xFFF8F5F0),
            Color(0xFFE9E0D1),
          ],
          textColor: AppColors.primaryBlack,
          chipColor: AppColors.softGold,
        );
    }
  }
}