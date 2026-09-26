import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../common/network/firebase_functions_service.dart';
import '../../../core/models/payment_order_model.dart';
import '../../../core/models/payment_result_model.dart';
import '../../../core/models/payment_verification_model.dart';
import 'payment_remote_datasource.dart';

class FirebasePaymentDataSource
    implements PaymentRemoteDataSource {
  FirebasePaymentDataSource({
    required FirebaseFunctionsService
    functionsService,
    FirebaseFirestore? firestore,
  })  : _functionsService = functionsService,
        _firestore =
            firestore ?? FirebaseFirestore.instance;

  final FirebaseFunctionsService
  _functionsService;

  final FirebaseFirestore _firestore;

  @override
  Future<PaymentOrderModel> createOrder({
    required double amount,
    required String receipt,
  }) async {
    final response =
    await _functionsService.callFunction(
      functionName: 'createOrder',
      data: {
        'amount': amount,
        'receipt': receipt,
      },
    );

    return PaymentOrderModel.fromJson(
      response,
    );
  }

  @override
  Future<PaymentResultModel> verifyPayment({
    required String paymentId,
    required String orderId,
    required String signature,
  }) async {
    final response =
    await _functionsService.callFunction(
      functionName: 'verifyPayment',
      data: {
        'razorpayPaymentId': paymentId,
        'razorpayOrderId': orderId,
        'razorpaySignature': signature,
      },
    );

    return PaymentResultModel.fromJson(
      response,
    );
  }

  @override
  Future<void> saveOrder({
    required Map<String, dynamic> orderData,
  }) async {
    final orderId =
    orderData['orderId'] as String;

    await _firestore
        .collection('orders')
        .doc(orderId)
        .set(orderData);
  }
}