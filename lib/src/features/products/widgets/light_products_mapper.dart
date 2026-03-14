import '../../../core/models/light_product_model.dart';
import '../../../core/models/product_model.dart';

extension LightToProductMapper on LightProductModel {
  ProductModel toProductModel() {
    return ProductModel(
      productId: productId,
      title: title,
      category: category,
      subCategory: subCategory,
      actualPrice: actualPrice,
      sellingPrice: sellingPrice,
      discount:
      actualPrice > sellingPrice
          ? (((actualPrice - sellingPrice) / actualPrice) * 100).round()
          : 0,
      inStock: true,
      averageRating: 0,
      description: '',
      baseColour: '',
      season: '',
      year: DateTime.now().year,
      usage: '',
      hasImage: true,
      slug: '',
      images: [
      ],
    );
  }
}
