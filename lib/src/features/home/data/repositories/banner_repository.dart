import '../../../../../widgets/images.dart';
import '../../domain/entities/banner_type.dart';
import '../../widgets/banner_data.dart';

class BannerRepository {
  static List<BannerData> getBanners(BannerType type) {
    switch (type) {
      case BannerType.women:
        return const [
          BannerData(
            image: AppImages.women_banner,
            text: "Women's Fashion · Flat 50% Off",
          ),
          BannerData(
            image: AppImages.women_banner_1,
            text: "Ethnic & Western · Trending",
          ),
          BannerData(
            image: AppImages.women_banner_3,
            text: "Women's Fashion · Flat 50% Off",
          ),

        ];

      case BannerType.men:
        return const [
          BannerData(
            image: AppImages.men_banner_1,
            text: "Men's Wear · New Season",
          ),
          BannerData(
            image: AppImages.men_banner_2,
            text: "Casuals · Premium Picks",
          ),
          BannerData(
            image: AppImages.men_banner_3,
            text: "Men's Wear · New Season",
          ),

        ];

      case BannerType.kids:
        return const [
          BannerData(
            image: AppImages.kids_banner_1,
            text: "Kids Collection · Fun Styles",
          ),
          BannerData(
            image: AppImages.kids_banner_2,
            text: "Playwear · Starting ₹399",
          ),
          BannerData(
            image: AppImages.kids_banner_3,
            text: "Kids Collection · Fun Styles",
          ),

        ];

      case BannerType.home:
      default:
        return const [
          BannerData(
            image: AppImages.home_banner_1,
            text: "Big Festive Sale · Up to 60%",
          ),
          BannerData(
            image: AppImages.home_banner_2,
            text: "New Arrivals · Trending Now",
          ),
          BannerData(
            image: AppImages.home_banner_3,
            text: "Big Festive Sale · Up to 60%",
          ),

        ];
    }
  }
}
