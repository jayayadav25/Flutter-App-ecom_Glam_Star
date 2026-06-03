import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/order_model.dart';
import '../data/order_repository_impl.dart';
import '../datasources/order_remote_datasources.dart';
import '../usecases/create_order_usecases.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final orderRemoteDatasourceProvider = Provider<OrderRemoteDatasource>((ref) {
  return OrderRemoteDatasource(
    firestore: ref.watch(firestoreProvider,),
  );
});

final orderRepositoryProvider = Provider<OrderRepositoryImpl>((ref) {

  return OrderRepositoryImpl(
    remote: ref.watch(
      orderRemoteDatasourceProvider,
    ),
  );
});

final createOrderUsecaseProvider = Provider<CreateOrderUsecase>((ref) {
  return CreateOrderUsecase(
    repository: ref.watch(
      orderRepositoryProvider,
    ),
  );
});

class OrderNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> createOrder(OrderModel order,) async {
    state = const AsyncLoading();
    try {
      await ref.read(createOrderUsecaseProvider,).call(order);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final orderProvider = AsyncNotifierProvider<OrderNotifier, void>(OrderNotifier.new,);
