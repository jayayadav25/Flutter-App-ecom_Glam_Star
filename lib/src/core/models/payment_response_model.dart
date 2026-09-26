import 'package:flutter/foundation.dart';

@immutable
class PaymentResponseModel {
  final String orderId;
  final double amount;
  final String currency;
  final String receipt;

  const PaymentResponseModel({
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.receipt,
  });

  factory PaymentResponseModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return PaymentResponseModel(
      orderId: map['orderId'] ?? '',
      amount:
      (map['amount'] ?? 0)
          .toDouble(),
      currency:
      map['currency'] ?? 'INR',
      receipt:
      map['receipt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'amount': amount,
      'currency': currency,
      'receipt': receipt,
    };
  }
}