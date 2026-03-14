import 'product_model.dart';

class ProductModelMapper {
  static ProductModel fromMap(Map<String, dynamic> map) {
    int safeInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      if (v is double) return v.toInt();
      return int.tryParse(v.toString()) ?? 0;
    }

    return ProductModel(
      productId: safeInt(map['product_id']),
      category: map['category'] ?? '',
      subCategory: map['sub_category'] ?? '',
      actualPrice: safeInt(map['actual_price']),
      discount: safeInt(map['discount']),
      sellingPrice: safeInt(map['selling_price']),
      inStock: map['in_stock'] ?? true,
      averageRating: safeInt(map['average_rating']),
      description: map['description'] ?? '',
      baseColour: map['baseColour'] ?? '',
      season: map['season'] ?? '',
      year: safeInt(map['year']),
      usage: map['usage'] ?? '',
      hasImage: map['has_image'] ?? false,
      title: map['title'] ?? '',
      slug: map['slug'] ?? '',
      images: (map['images'] as List? ?? [])
          .map((e) => ProductImage.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}
