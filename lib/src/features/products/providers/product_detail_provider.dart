import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/product_model.dart';

final productDetailProvider =
FutureProvider.family<ProductModel, int>((ref, productId) async {
  final doc = await FirebaseFirestore.instance
      .collection('products')
      .doc(productId.toString())
      .get();

  if (!doc.exists) {
    throw Exception("Product not found");
  }

  final data = doc.data()!;

  return ProductModel(
    productId: (data['product_id'] as num).toInt(),
    category: data['category'] ?? '',
    subCategory: data['sub_category'] ?? '',
    actualPrice: (data['actual_price'] as num).toInt(),
    discount: (data['discount'] as num).toInt(),
    sellingPrice: (data['selling_price'] as num).toInt(),
    inStock: data['in_stock'] ?? true,
    averageRating: (data['average_rating'] as num).toInt(),
    description: data['description'] ?? '',
    baseColour: data['baseColour'] ?? '',
    season: data['season'] ?? '',
    year: (data['year'] as num).toInt(),
    usage: data['usage'] ?? '',
    hasImage: data['has_image'] ?? false,
    title: data['title'] ?? '',
    slug: data['slug'] ?? '',
    images: (data['images'] as List)
        .map((e) => ProductImage.fromJson(e))
        .toList(),
  );
});
