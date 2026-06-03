import 'package:flutter/material.dart';

class PaymentMethodModel {
  final String id;
  final String title;
  final IconData icon;

  const PaymentMethodModel({
    required this.id,
    required this.title,
    required this.icon,
  });
}

class PaymentMethods {
  static const cod = PaymentMethodModel(
    id: 'cod',
    title: 'Cash on Delivery',
    icon: Icons.payments_outlined,
  );

  static const upi = PaymentMethodModel(
    id: 'upi',
    title: 'UPI',
    icon: Icons.qr_code,
  );

  static const card = PaymentMethodModel(
    id: 'card',
    title: 'Credit / Debit Card',
    icon: Icons.credit_card,
  );

  static List<PaymentMethodModel> list = [
    cod,
    upi,
    card,
  ];
}