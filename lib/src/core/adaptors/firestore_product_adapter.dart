import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class FirestoreProductAdapter {
  static ProductModel fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ProductModel(
      productId: (data['product_id'] ?? 0) as int,
      category: data['category'] ?? '',
      subCategory: data['sub_category'] ?? '',
      actualPrice: (data['actual_price'] ?? 0).toInt(),
      discount: (data['discount'] ?? 0).toInt(),
      sellingPrice: (data['selling_price'] ?? 0).toInt(),
      inStock: data['in_stock'] ?? true,
      averageRating: (data['average_rating'] ?? 0).toInt(),
      description: data['description'] ?? '',
      baseColour: data['baseColour'] ?? '',
      season: data['season'] ?? '',
      year: (data['year'] ?? 2024).toInt(),
      usage: data['usage'] ?? '',
      hasImage: data['has_image'] ?? false,
      title: data['title'] ?? '',
      slug: data['slug'] ?? '',
      images: (data['images'] as List<dynamic>? ?? [])
          .map((e) => ProductImage.fromJson(e))
          .toList(),
    );
  }
}
