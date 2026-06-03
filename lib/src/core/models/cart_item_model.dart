import 'package:flutter/foundation.dart';

@immutable
class CartItemModel {
  final String productId;
  final String title;
  final String image;
  final double sellingPrice;
  final double actualPrice;
  final int quantity;
  final bool isSelected;
  final DateTime updatedAt;

  const CartItemModel({
    required this.productId,
    required this.title,
    required this.image,
    required this.sellingPrice,
    required this.actualPrice,
    required this.quantity,
    required this.isSelected,
    required this.updatedAt,
  });

  double get mrpTotal => actualPrice * quantity;

  double get sellingTotal => sellingPrice * quantity;

  CartItemModel copyWith({
    int? quantity,
    bool? isSelected,
  }) {
    return CartItemModel(
      productId: productId,
      title: title,
      image: image,
      sellingPrice: sellingPrice,
      actualPrice: actualPrice,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
      updatedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'image': image,
      'sellingPrice': sellingPrice,
      'actualPrice': actualPrice,
      'quantity': quantity,
      'isSelected': isSelected,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productId: map['productId'],
      title: map['title'],
      image: map['image'],
      sellingPrice: (map['sellingPrice'] as num).toDouble(),
      actualPrice: (map['actualPrice'] as num).toDouble(),
      quantity: map['quantity'],
      isSelected: map['isSelected'] ?? true,
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}