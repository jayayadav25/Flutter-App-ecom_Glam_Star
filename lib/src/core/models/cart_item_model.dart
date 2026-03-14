import 'package:firebase_mastery_app/src/core/models/product_model_mapper.dart';

import 'product_model.dart';

class CartItemModel {
  final ProductModel product;
  final int quantity;

  CartItemModel({
    required this.product,
    required this.quantity,
  });

  // MRP total
  double get mrpTotal =>
      (product.actualPrice * quantity).toDouble();

  // Selling total
  double get sellingTotal =>
      (product.sellingPrice * quantity).toDouble();

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      product: ProductModelMapper.fromMap(
        Map<String, dynamic>.from(map['product']),
      ),
      quantity: map['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }
}
