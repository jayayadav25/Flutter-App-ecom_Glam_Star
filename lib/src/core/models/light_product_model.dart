
import 'dart:convert';

List<LightProductModel> lightProductModelFromJson(String str) => List<LightProductModel>.from(json.decode(str).map((x) => LightProductModel.fromJson(x)));

String lightProductModelToJson(List<LightProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LightProductModel {
  int productId;
  String title;
  String category;
  String subCategory;
  int sellingPrice;
  int actualPrice;
  int discount;
  double averageRating;
  String thumbnail;
  bool hasImage;
  String slug;

  LightProductModel({
    required this.productId,
    required this.title,
    required this.category,
    required this.subCategory,
    required this.sellingPrice,
    required this.actualPrice,
    required this.discount,
    required this.averageRating,
    required this.thumbnail,
    required this.hasImage,
    required this.slug,
  });

  factory LightProductModel.fromJson(Map<String, dynamic> json) => LightProductModel(
    productId: (json['product_id'] as num?)?.toInt() ?? 0,
    title: json['title'] ?? '',
    category: json['category'] ?? '',
    subCategory: json['sub_category'] ?? '',
    sellingPrice: (json['selling_price'] as num?)?.toInt() ?? 0,
    actualPrice: (json['actual_price'] as num?)?.toInt() ?? 0,
    discount: (json['discount'] as num?)?.toInt() ?? 0,
    averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
    thumbnail: json['thumbnail'] ?? '',
    hasImage: json["has_image"],
    slug: json['slug'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "title": title,
    "category": category,
    "sub_category": subCategory,
    "selling_price": sellingPrice,
    "actual_price": actualPrice,
    "discount": discount,
    "average_rating": averageRating,
    "thumbnail": thumbnail,
    "has_image": hasImage,
    "slug": slug,
  };
}
