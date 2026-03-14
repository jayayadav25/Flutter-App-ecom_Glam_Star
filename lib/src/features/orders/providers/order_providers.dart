import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/order_model.dart';
import '../data/order_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';


// Repository provider
final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository();
});

// Order history provider
final userOrdersProvider =
StreamProvider<List<OrderModel>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return const Stream.empty();

  return ref.read(orderRepositoryProvider).watchOrders(user.uid);
});
