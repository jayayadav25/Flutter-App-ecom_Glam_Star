import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../cart/providers/cart_providers.dart';
import '../../address/provider/address_provider.dart';
import '../../../core/models/order_model.dart';
import '../providers/order_providers.dart';
import 'order_repository.dart';

class OrderController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> placeOrder({
    required String paymentMethod,
    required double totalAmount,
  }) async {
    state = const AsyncLoading();

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      // Cart items
      final cartItems = ref.read(cartProvider).value ?? [];
      if (cartItems.isEmpty) {
        throw Exception("Cart is empty");
      }

      // Selected items
      final address = ref.read(selectedAddressProvider);
      if (address == null) {
        throw Exception("No address selected");
      }

      // Order items
      final orderItems = cartItems.map((item) {
        return {
          'productId': item.product.productId,
          'title': item.product.title,
          'price': item.product.sellingPrice,
          'quantity': item.quantity,
          'image': item.product.images.first,
        };
      }).toList();

      final order = OrderModel(
        id: '',
        userId: user.uid,
        totalAmount: totalAmount,
        status: 'Placed',
        deliveryStatus: 'Placed',
        paymentMethod: paymentMethod,
        createdAt: DateTime.now(),
        address: address.toMap(),
        items: orderItems,
      );

      // Save to firestore
      await ref
          .read(orderRepositoryProvider)
          .createOrder(order);

      // Clear cart after success
      await ref.read(cartProvider.notifier).clearCart();

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}

// Provider
final orderControllerProvider =
AsyncNotifierProvider<OrderController, void>(
  OrderController.new,
);
