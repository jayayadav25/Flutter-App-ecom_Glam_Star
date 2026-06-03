import '../../../../widgets/images.dart';
import '../domain/entities/sub_category_type.dart';
class SubCategoryData {
  final String label;
  final String value;
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

          SubCategoryData(
            label: 'Dresses',
            value: 'dresses',
            image: AppImages.women_dresses,
          ),

          SubCategoryData(
            label: 'Tops',
            value: 'tops',
            image: AppImages.women_top,
          ),

          SubCategoryData(
            label: 'Kurta',
            value:  'kurta-sets',
            image: AppImages.kurta,
          ),

          SubCategoryData(
            label: 'Sarees',
            value:  'sarees',
            image: AppImages.saree,
          ),

          SubCategoryData(
            label: 'Handbags',
            value: 'handbags',
            image: AppImages.handbag,
          ),
          SubCategoryData(
            label: 'Footwear',
            value: 'flats',
            image: AppImages.women_sandles,
          ),



          SubCategoryData(
            label: 'Jewelery',
            value: 'jewellery-set',
            image: AppImages.jewelry,
          ),
        ];

      case SubCategoryType.men:
        return const [
          SubCategoryData(
            label: 'Shirts',
            value: 'shirts',
            image: AppImages.men_shirt,
          ),

          SubCategoryData(
            label: 'T-shirts',
            value: 'tshirts',
            image: AppImages.men_tshirt,
          ),

          SubCategoryData(
            label: 'Jeans',
            value: 'casual-jeans',
            image: AppImages.men_jeans,
          ),
          SubCategoryData(
            label: 'Shoes',
            value: 'casual-shoes',
            image: AppImages.men_shoes,
          ),

          SubCategoryData(
            label: 'Watches',
            value: 'watches',
            image: AppImages.watch,
          ),


          SubCategoryData(
            label: 'Accessories',
            value: 'accessory-gift-set',
            image: AppImages.men_watch3,
          ),
        ];

      case SubCategoryType.kids:
        return const [
          SubCategoryData(
            label: 'T-Shirts',
            value: 'tshirts',
            image: AppImages.kids_tshirt,
          ),

          SubCategoryData(
            label: 'Caps',
            value: 'caps',
            image: AppImages.kids_cap,
          ),

          SubCategoryData(
            label: 'Shorts',
            value: 'shorts',
            image: AppImages.kids_shorts,
          ),
          SubCategoryData(
            label: 'Everyday Wear',
            value: 'dresses',
            image: AppImages.kids_dress,
          ),

          SubCategoryData(
            label: 'Shoes',
            value: 'casual-shoes',
            image: AppImages.men_shoes,
          ),

          SubCategoryData(
            label: 'Global stores',
            value: 'dresses',
            image: AppImages.kids14,
          ),
        ];
    }
  }
}
