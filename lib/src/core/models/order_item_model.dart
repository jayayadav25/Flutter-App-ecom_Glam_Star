import 'package:flutter/foundation.dart';

@immutable
class OrderItemModel {
  final String productId;
  final String productName;
  final String productImage;

  final String category;
  final String brand;

  final String size;
  final String color;

  final int quantity;

  final double actualPrice;
  final double sellingPrice;

  const OrderItemModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.category,
    required this.brand,
    required this.size,
    required this.color,
    required this.quantity,
    required this.actualPrice,
    required this.sellingPrice,
  });

  factory OrderItemModel.fromMap(
      Map<String, dynamic> map,
      ) {
    double parse(dynamic value) {
      if (value == null) return 0;

      if (value is int) {
        return value.toDouble();
      }

      if (value is double) {
        return value;
      }

      if (value is num) {
        return value.toDouble();
      }

      return 0;
    }

    return OrderItemModel(
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      productImage: map['productImage'] ?? '',

      category: map['category'] ?? '',
      brand: map['brand'] ?? '',

      size: map['size'] ?? '',
      color: map['color'] ?? '',

      quantity: map['quantity'] ?? 1,

      actualPrice: parse(
        map['actualPrice'],
      ),

      sellingPrice: parse(
        map['sellingPrice'],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,

      'category': category,
      'brand': brand,

      'size': size,
      'color': color,

      'quantity': quantity,

      'actualPrice': actualPrice,
      'sellingPrice': sellingPrice,
    };
  }

  double get totalPrice =>
      sellingPrice * quantity;

  double get totalActualPrice =>
      actualPrice * quantity;

  double get totalDiscount =>
      (actualPrice - sellingPrice) *
          quantity;
}