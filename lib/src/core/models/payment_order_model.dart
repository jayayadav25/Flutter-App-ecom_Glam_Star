import 'package:flutter/foundation.dart';

@immutable
class PaymentOrderModel {
  final bool success;
  final String orderId;
  final double amount;
  final String currency;
  final String receipt;

  const PaymentOrderModel({
    required this.success,
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.receipt,
  });


  factory PaymentOrderModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return PaymentOrderModel(
      success: map['success'] ?? false,
      orderId: map['orderId'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      currency: map['currency'] ?? 'INR',
      receipt: map['receipt'] ?? '',
    );
  }

  factory PaymentOrderModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return PaymentOrderModel.fromMap(json);
  }
}
