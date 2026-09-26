import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/order_model.dart';
import '../../../core/models/payment_result_model.dart';
import '../data/payment_repository.dart';
import 'payment_state.dart';

class PaymentNotifier extends StateNotifier<PaymentState> {
  final PaymentRepository repository;

  PaymentNotifier(this.repository) : super(const PaymentState());
  Future<PaymentResultModel?> processPayment({
    required double amount,
    required String receipt,
    required String userName,
    required String userEmail,
    required String userPhone,
  }) async {
    try {
      state = state.copyWith(
        isLoading: true,
        errorMessage: null,
      );

      // Create Razorpay Order
      final order = await repository.createOrder(
        amount: amount,
        receipt: receipt,
      );
      debugPrint(
        'ORDER CREATED => ${order.orderId}',
      );

      // Open Razorpay Checkout
      final paymentResult = await repository.startPayment(
        razorpayOrderId: order.orderId,
        amount: amount,
        userName: userName,
        userEmail: userEmail,
        userPhone: userPhone,
      );
      debugPrint(
        'PAYMENT RESULT => ${paymentResult.toJson()}',
      );
      if (!paymentResult.verified) {
        throw Exception(
          'Payment verification failed',
        );
      }

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        orderId: paymentResult.orderId,
        paymentId:
        paymentResult.paymentId,
      );

      return paymentResult;
    }
    catch (e, stackTrace) {
      debugPrint(
        'PAYMENT NOTIFIER ERROR => $e',
      );
      debugPrint(
        stackTrace.toString(),
      );

      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      );
      rethrow;
      //return null;
    }
  }


  Future<void> placeOrderAfterPayment({
    required Map<String, dynamic> orderData,
  }) async {
    try {
      state = state.copyWith(
        isLoading: true,
        errorMessage: null,
      );

      await repository.saveOrder(
        orderData: orderData,
      );

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
      );
    }
    catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );

      rethrow;
    }
  }

  Future<void> saveOrder(
      OrderModel order,
      PaymentResultModel paymentResult,
      ) async {
    await repository.saveOrder(
      orderData: {
        ...order.toMap(),

        'orderId': order.id,

        'paymentId':
        paymentResult.paymentId,

        'razorpayOrderId':
        paymentResult.orderId,

        'paymentVerified':
        paymentResult.verified,
      },
    );
  }

  void reset() {
    state = const PaymentState();
  }

}