import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../usecases/cancel_order_usecase.dart';
import 'order_providers.dart';

final cancelOrderUsecaseProvider = Provider<CancelOrderUsecase>((ref) {
  return CancelOrderUsecase(
    repository: ref.watch(orderRepositoryProvider,),
  );
});

class CancelOrderNotifier extends AsyncNotifier<void> {

  @override
  Future<void> build() async {}

  Future<void> cancelOrder(String orderId,) async {
    state = const AsyncLoading();

    try {
      await ref.read(cancelOrderUsecaseProvider,).call(orderId);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final cancelOrderProvider = AsyncNotifierProvider
<CancelOrderNotifier, void>(
  CancelOrderNotifier.new,
);