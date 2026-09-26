import 'package:flutter/foundation.dart';

@immutable
class PaymentResultModel {
  final bool verified;
  final String paymentId;
  final String orderId;

  const PaymentResultModel({
    required this.verified,
    required this.paymentId,
    required this.orderId,
  });

  factory PaymentResultModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return PaymentResultModel(
      verified: json['verified'] ?? false,
      paymentId: json['paymentId'] ?? '',
      orderId: json['orderId'] ?? '',
    );
  }

  factory PaymentResultModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return PaymentResultModel.fromJson(map);
  }

  Map<String, dynamic> toJson() {
    return {
      'verified': verified,
      'paymentId': paymentId,
      'orderId': orderId,
    };
  }
}