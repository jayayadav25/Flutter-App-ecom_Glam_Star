import '../../../core/models/payment_order_model.dart';
import '../../../core/models/payment_result_model.dart';

abstract class PaymentRepository {
  Future<PaymentOrderModel> createOrder({
    required double amount,
    required String receipt,
  });

  Future<PaymentResultModel> startPayment({
    required String razorpayOrderId,
    required double amount,
    required String userName,
    required String userEmail,
    required String userPhone,
  });

  Future<PaymentResultModel> verifyPayment({
    required String paymentId,
    required String orderId,
    required String signature,
  });

  Future<void> saveOrder({
    required Map<String, dynamic> orderData,
  });
}