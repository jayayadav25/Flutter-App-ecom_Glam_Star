import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/models/order_model.dart';
import '../usecases/get_order_usecases.dart';
import 'order_providers.dart';

final getOrdersUsecaseProvider = Provider<GetOrdersUsecase>((ref) {
  return GetOrdersUsecase(
    repository: ref.watch(
      orderRepositoryProvider,
    ),
  );
});

final userOrdersProvider = StreamProvider<List<OrderModel>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return const Stream.empty();
  }
  return ref.read(getOrdersUsecaseProvider,).call(user.uid);
});