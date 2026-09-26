import 'package:flutter/foundation.dart';

@immutable
class PaymentVerificationResponseModel {
  final bool verified;

  final String paymentId;
  final String orderId;

  const PaymentVerificationResponseModel({
    required this.verified,
    required this.paymentId,
    required this.orderId,
  });

  factory PaymentVerificationResponseModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return PaymentVerificationResponseModel(
      verified:
      map['verified'] ?? false,

      paymentId:
      map['paymentId'] ?? '',

      orderId:
      map['orderId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'verified': verified,
      'paymentId': paymentId,
      'orderId': orderId,
    };
  }
}