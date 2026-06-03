import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/order_service.dart';
import '../datasources/checkout_datasource.dart';
import '../datasources/checkout_remote_datasource.dart';
import '../repository/check_repository_impl.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final orderServiceProvider = Provider<OrderService>((ref) {
  return OrderService(
    firestore: ref.watch(firestoreProvider,),
  );
});

final checkoutLocalDatasourceProvider = Provider<CheckoutLocalDatasource>((ref) {
  return CheckoutLocalDatasource();
});

final checkoutRemoteDatasourceProvider = Provider<CheckoutRemoteDatasource>((ref) {

  return CheckoutRemoteDatasource(
    orderService: ref.watch(orderServiceProvider,),
  );
});

final checkoutRepositoryProvider = Provider<CheckoutRepositoryImpl>((ref) {
  return CheckoutRepositoryImpl(
    local: ref.watch(
      checkoutLocalDatasourceProvider,
    ),

    remote: ref.watch(
      checkoutRemoteDatasourceProvider,
    ),
  );
});