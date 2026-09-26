import '../data/payment_repository.dart';

class SaveOrderUseCase {
  final PaymentRepository repository;

  SaveOrderUseCase({
    required this.repository,
  });

  Future<void> call({
    required Map<String, dynamic> orderData,
  }) async {
    final orderId =
    orderData['orderId'];

    if (orderId == null ||
        orderId.toString().isEmpty) {
      throw Exception(
        'Order Id is required',
      );
    }

    await repository.saveOrder(
      orderData: orderData,
    );
  }
}