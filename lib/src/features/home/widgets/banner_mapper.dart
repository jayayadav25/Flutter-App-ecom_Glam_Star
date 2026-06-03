import '../domain/entities/banner_type.dart';
import '../providers/home_provider.dart';

BannerType mapHomeTabToBanner(HomeTab tab) {
  switch (tab) {
    case HomeTab.women:
      return BannerType.women;

    case HomeTab.men:
      return BannerType.men;

    case HomeTab.kids:
      return BannerType.kids;

    case HomeTab.home:
    default:
      return BannerType.home;
  }
}

