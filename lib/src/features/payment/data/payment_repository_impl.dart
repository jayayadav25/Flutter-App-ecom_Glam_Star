import 'package:firebase_mastery_app/src/features/payment/data/payment_repository.dart';
import '../../../core/models/payment_order_model.dart';
import '../../../core/models/payment_result_model.dart';
import '../datasources/payment_remote_datasource.dart';
import '../service/razorpay_service.dart';

class PaymentRepositoryImpl
    implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;
  final RazorpayService razorpayService;

  PaymentRepositoryImpl({
    required this.remoteDataSource,
    required this.razorpayService,
  });

  @override
  Future<PaymentOrderModel> createOrder({
    required double amount,
    required String receipt,
  }) {
    return remoteDataSource.createOrder(
      amount: amount,
      receipt: receipt,
    );
  }

  @override
  Future<PaymentResultModel> startPayment({
    required String razorpayOrderId,
    required double amount,
    required String userName,
    required String userEmail,
    required String userPhone,
  }) {
    return razorpayService.startPayment(
      razorpayOrderId: razorpayOrderId,
      amount: amount,
      userName: userName,
      userEmail: userEmail,
      userPhone: userPhone,
      remoteDataSource: remoteDataSource,
    );
  }

  @override
  Future<PaymentResultModel> verifyPayment({
    required String paymentId,
    required String orderId,
    required String signature,
  }) {
    return remoteDataSource.verifyPayment(
      paymentId: paymentId,
      orderId: orderId,
      signature: signature,
    );
  }

  @override
  Future<void> saveOrder({
    required Map<String, dynamic> orderData,
  }) {
    return remoteDataSource.saveOrder(
      orderData: orderData,
    );
  }
}
