class SearchProductModel {
  final int productId;
  final String title;
  final String category;
  final String subCategory;
  final double price;
  final String image;

  SearchProductModel({
    required this.productId,
    required this.title,
    required this.category,
    required this.subCategory,
    required this.price,
    required this.image,
  });

  factory SearchProductModel.fromJson(
      Map<String, dynamic> json) {
    return SearchProductModel(
      productId: json['product_id'],
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      subCategory: json['sub_category'] ?? '',
      price: (json['selling_price'] ?? 0).toDouble(),
      image: json['image'] ?? '',
    );
  }
}
