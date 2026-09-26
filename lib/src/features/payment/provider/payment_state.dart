import 'package:flutter/foundation.dart';

@immutable
class PaymentState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? orderId;
  final String? paymentId;

  const PaymentState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.orderId,
    this.paymentId,
  });

  PaymentState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? orderId,
    String? paymentId,
  }) {
    return PaymentState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      orderId: orderId ?? this.orderId,
      paymentId: paymentId ?? this.paymentId,
    );
  }
}