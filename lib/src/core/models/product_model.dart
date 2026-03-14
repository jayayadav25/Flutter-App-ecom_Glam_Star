import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  int productId;
  String category;
  String subCategory;
  int actualPrice;
  int discount;
  int sellingPrice;
  bool inStock;
  int averageRating;
  String description;
  String baseColour;
  String season;
  int year;
  String usage;
  bool hasImage;
  String title;
  String slug;
  List<ProductImage> images;

  ProductModel({
    required this.productId,
    required this.category,
    required this.subCategory,
    required this.actualPrice,
    required this.discount,
    required this.sellingPrice,
    required this.inStock,
    required this.averageRating,
    required this.description,
    required this.baseColour,
    required this.season,
    required this.year,
    required this.usage,
    required this.hasImage,
    required this.title,
    required this.slug,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    productId: (json['product_id'] as num?)?.toInt() ?? 0,
    category: json['category'] ?? '',
    subCategory: json['sub_category'] ?? '',
    actualPrice: (json['actual_price'] as num?)?.toInt() ?? 0,
    discount: (json['discount'] as num?)?.toInt() ?? 0,
    sellingPrice: (json['selling_price'] as num?)?.toInt() ?? 0,
    inStock: json['in_stock'] ?? true,
    averageRating: (json['average_rating'] as num?)?.toInt() ?? 0,
    description: json['description'] ?? '',
    baseColour: json['baseColour'] ?? '',
    season: json['season'] ?? '',
    year: (json['year'] as num?)?.toInt() ?? 0,
    usage: json['usage'] ?? '',
    hasImage: json['has_image'] ?? false,
    title: json['title'] ?? '',
    slug: json['slug'] ?? '',
    images: List<ProductImage>.from(json["images"].map((x) => ProductImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "category": category,
    "sub_category": subCategory,
    "actual_price": actualPrice,
    "discount": discount,
    "selling_price": sellingPrice,
    "in_stock": inStock,
    "average_rating": averageRating,
    "description": description,
    "baseColour": baseColour,
    "season": season,
    "year": year,
    "usage": usage,
    "has_image": hasImage,
    "title": title,
    "slug": slug,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };
  Map<String, dynamic> toMap() {
    return {
      "product_id": productId,
      "category": category,
      "sub_category": subCategory,
      "actual_price": actualPrice,
      "discount": discount,
      "selling_price": sellingPrice,
      "in_stock": inStock,
      "average_rating": averageRating,
      "description": description,
      "baseColour": baseColour,
      "season": season,
      "year": year,
      "usage": usage,
      "has_image": hasImage,
      "title": title,
      "slug": slug,
      "images": images.map((e) => e.toJson()).toList(),
    };
  }

}

class ProductImage  {
  String url;
  String type;

  ProductImage ({
    required this.url,
    required this.type,
  });

  factory ProductImage .fromJson(Map<String, dynamic> json) => ProductImage (
    url: json["url"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "type": type,
  };
}
