import '../../../core/models/payment_result_model.dart';
import '../data/payment_repository.dart';

class VerifyPaymentUseCase {
  final PaymentRepository repository;

  VerifyPaymentUseCase({
    required this.repository,
  });

  Future<PaymentResultModel> call({
    required String paymentId,
    required String orderId,
    required String signature,
  }) async {
    if (paymentId.trim().isEmpty) {
      throw Exception(
        'Payment Id is required',
      );
    }

    if (orderId.trim().isEmpty) {
      throw Exception(
        'Order Id is required',
      );
    }

    if (signature.trim().isEmpty) {
      throw Exception(
        'Signature is required',
      );
    }

    return repository.verifyPayment(
      paymentId: paymentId,
      orderId: orderId,
      signature: signature,
    );
  }
}