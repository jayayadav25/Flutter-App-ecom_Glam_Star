import '../../../../widgets/images.dart';
import '../domain/entities/banner_type.dart';
import '../widgets/banner_data.dart';
class BannerRepository {
  static List<BannerData> getBanners(BannerType type) {
    switch (type) {
      case BannerType.women:
        return const [
          BannerData(
            image: AppImages.women_banner,
            text: 'Luxury Women Collection',
          ),

          BannerData(
            image: AppImages.women_banner_1,
            text: 'Elegant Fashion Picks',
          ),

          BannerData(
            image: AppImages.women_banner_3,
            text: 'Trending Styles 2026',
          ),
        ];

      case BannerType.men:
        return const [
          BannerData(
            image: AppImages.men_banner_1,
            text: 'Premium Menswear',
          ),

          BannerData(
            image: AppImages.men_banner_2,
            text: 'Modern Street Collection',
          ),

          BannerData(
            image: AppImages.men_banner_3,
            text: 'Luxury Essentials',
          ),
        ];

      case BannerType.kids:
        return const [
          BannerData(
            image: AppImages.kids_banner_1,
            text: 'Kids Fashion World',
          ),

          BannerData(
            image: AppImages.kids_banner_2,
            text: 'Cute & Trendy Styles',
          ),

          BannerData(
            image: AppImages.kids_banner_3,
            text: 'Playful Luxury Looks',
          ),
        ];

      case BannerType.home:
      default:
        return const [
          BannerData(
            image: AppImages.banner_1,
            text: '',
          ),

          BannerData(
            image: AppImages.banner_2,
            text: '',
          ),

          BannerData(
            image: AppImages.banner_3,
            text: '',
          ),

          BannerData(
            image: AppImages.banner_4,
            text: '',
          ),

          BannerData(
            image: AppImages.banner_5,
            text: '',
          ),

          BannerData(
            image: AppImages.banner_6,
            text: '',
          ),
        ];
    }
  }
}

