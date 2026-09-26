import '../../../core/models/payment_order_model.dart';
import '../data/payment_repository.dart';

class CreateOrderUseCase {
  final PaymentRepository repository;

  CreateOrderUseCase({
    required this.repository,
  });

  Future<PaymentOrderModel> call({
    required double amount,
    required String receipt,
  }) async {
    if (amount <= 0) {
      throw Exception(
        'Amount must be greater than zero',
      );
    }

    if (receipt.trim().isEmpty) {
      throw Exception(
        'Receipt cannot be empty',
      );
    }

    return repository.createOrder(
      amount: amount,
      receipt: receipt,
    );
  }
}