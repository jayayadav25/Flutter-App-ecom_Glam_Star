import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class OrderModel {
  final String id;
  final String userId;
  // PRICE DETAILS
  final double actualPrice;
  final double sellingPrice;
  final double productDiscount;
  final double couponDiscount;
  final double offerDiscount;
  final double shippingFee;
  final double totalSaved;
  final double totalAmount;
  // STATUS
  final String status;
  final String deliveryStatus;
  // PAYMENT
  final String paymentMethod;
  final String paymentStatus;
  // DATE
  final DateTime createdAt;
  // ADDRESS
  final Map<String, dynamic> address;
  // ITEMS
  final List<Map<String, dynamic>> items;
  // COUPON
  final String? couponCode;
  const OrderModel({
    required this.id,
    required this.userId,
    required this.actualPrice,
    required this.sellingPrice,
    required this.productDiscount,
    required this.couponDiscount,
    required this.offerDiscount,
    required this.shippingFee,
    required this.totalSaved,
    required this.totalAmount,
    required this.status,
    required this.deliveryStatus,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.createdAt,
    required this.address,
    required this.items,
    this.couponCode,
  });

  // ITEM COUNT
  int get totalItems => items.length;
  bool get isFreeDelivery => shippingFee == 0;
  bool get isDelivered => deliveryStatus == 'Delivered';
  factory OrderModel.fromMap(Map<String, dynamic> map, String documentId,) {
    double parse(dynamic value) {
      if (value == null) {
        return 0;
      }
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

    return OrderModel(
      id: documentId,

      // USER
      userId: map['userId'] ?? '',

      // PRICE DETAILS
      actualPrice: parse(map['actualPrice']),
      sellingPrice: parse(map['sellingPrice']),
      productDiscount: parse(map['productDiscount']),
      couponDiscount: parse(map['couponDiscount']),
      offerDiscount: parse(map['offerDiscount']),
      shippingFee: parse(map['shippingFee']),
      totalSaved: parse(map['totalSaved']),
      totalAmount: parse(map['totalAmount']),

      // STATUS
      status: map['status'] ?? '',
      deliveryStatus: map['deliveryStatus'] ?? 'Placed',

      // PAYMENT
      paymentMethod: map['paymentMethod'] ?? '',
      paymentStatus: map['paymentStatus'] ?? '',

      // DATE
      createdAt: map['createdAt'] != null ? map['createdAt'].toDate() : DateTime.now(),

      // ADDRESS
      address: Map<String, dynamic>.from(map['address'] ?? {},),

      // ITEMS
      items: List<Map<String, dynamic>>.from(map['items'] ?? [],),

      // COUPON
      couponCode: map['couponCode'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'actualPrice': actualPrice,
      'sellingPrice': sellingPrice,
      'productDiscount': productDiscount,
      'couponDiscount': couponDiscount,
      'offerDiscount': offerDiscount,
      'shippingFee': shippingFee,
      'totalSaved': totalSaved,
      'totalAmount': totalAmount,
      'status': status,
      'deliveryStatus': deliveryStatus,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'createdAt': FieldValue.serverTimestamp(),
      'address': address,
      'items': items,
      'couponCode': couponCode,
    };
  }
}