import '../../../../../widgets/images.dart';
import '../../domain/entities/sub_category_type.dart';

class SubCategoryData {
  final String label; // UI
  final String value; // Firestore
  final String image;

  const SubCategoryData({
    required this.label,
    required this.value,
    required this.image,
  });
}

class SubCategoryRepository {
  static List<SubCategoryData> getSubCategories(SubCategoryType type) {
    switch (type) {
      case SubCategoryType.women:
        return const [
          SubCategoryData(label: 'Tops', value: 'tops', image: AppImages.women_top),
          SubCategoryData(label: 'Dresses', value: 'dresses', image: AppImages.women_dresses),
          SubCategoryData(label: 'Kurtis', value: 'kurtis', image: AppImages.women_dresses),
          SubCategoryData(label: 'Jeans', value: 'jeans', image: AppImages.women_jeans),
          SubCategoryData(label: 'Handbags', value: 'handbags', image: AppImages.handbag),
          SubCategoryData(label: 'Heels', value: 'heels', image: AppImages.women_sandles),
        ];

      case SubCategoryType.men:
        return const [
          SubCategoryData(label: 'Shirts', value: 'shirts', image: AppImages.men_shirt),
          SubCategoryData(label: 'T-Shirts', value: 'tshirts', image: AppImages.men_tshirt),
          SubCategoryData(label: 'Jeans', value: 'jeans', image: AppImages.men_jeans),
          SubCategoryData(label: 'Track Pants', value: 'track-pants', image: AppImages.men_jeans),
          SubCategoryData(label: 'Shoes', value: 'casual-shoes', image: AppImages.men_shoes),
          SubCategoryData(label: 'Watches', value: 'watches', image: AppImages.watch),
        ];

      case SubCategoryType.kids:
      default:
        return const [
          SubCategoryData(label: 'Clothing Sets', value: 'clothing-set', image: AppImages.kids_dress),
          SubCategoryData(label: 'Shorts', value: 'shorts', image: AppImages.kids_shorts),
          SubCategoryData(label: 'T-Shirts', value: 'tshirts', image: AppImages.kids_tshirt),
          SubCategoryData(label: 'Sandals', value: 'sandals', image: AppImages.kids_sandles),
          SubCategoryData(label: 'Night Suits', value: 'night-suits', image: AppImages.kids_nightsuit),
          SubCategoryData(label: 'Caps', value: 'caps', image: AppImages.kids_cap),
        ];
    }
  }
}
