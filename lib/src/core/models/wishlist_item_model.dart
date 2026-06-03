import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistItemModel {
  final int productId;
  final String title;
  final String image;
  final double sellingPrice;
  final double actualPrice;
  final int discount;
  final double rating;
  final DateTime addedAt;

  WishlistItemModel({
    required this.productId,
    required this.title,
    required this.image,
    required this.sellingPrice,
    required this.actualPrice,
    required this.discount,
    required this.rating,
    required this.addedAt,
  });

  factory WishlistItemModel.fromMap(Map<String, dynamic> map,) {
    return WishlistItemModel(
      productId: map['productId'] ?? 0,
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      sellingPrice: (map['sellingPrice'] ?? 0).toDouble(),
      actualPrice: (map['actualPrice'] ?? 0).toDouble(),
      discount: map['discount'] ?? 0,
      rating: (map['rating'] ?? 0).toDouble(),
      addedAt: map['addedAt'] is Timestamp ? (map['addedAt'] as Timestamp).toDate() : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'image': image,
      'sellingPrice': sellingPrice,
      'actualPrice': actualPrice,
      'discount': discount,
      'rating': rating,
      'addedAt': addedAt,
    };
  }
}