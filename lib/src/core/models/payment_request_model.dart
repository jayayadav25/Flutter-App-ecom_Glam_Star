import 'package:flutter/foundation.dart';

@immutable
class PaymentRequestModel {
  final double amount;
  final String receipt;
  final String userId;

  final String customerName;
  final String customerEmail;
  final String customerPhone;

  const PaymentRequestModel({
    required this.amount,
    required this.receipt,
    required this.userId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'receipt': receipt,
      'userId': userId,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
    };
  }
}