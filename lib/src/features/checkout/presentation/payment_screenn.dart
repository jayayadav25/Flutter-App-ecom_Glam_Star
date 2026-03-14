//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import '../../cart/providers/cart_providers.dart';
// import '../../orders/data/order_controller.dart';
// import '../../orders/presentation/simple_order_service.dart';
// import '../../orders/providers/order_providers.dart';
// import 'order_success_screen.dart';
//
// class PaymentScreen extends ConsumerWidget {
//   const PaymentScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final service = SimpleOrderService();
//     return Scaffold(
//       appBar: AppBar(title: const Text("Payment")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _paymentTile("Cash on Delivery"),
//             _paymentTile("UPI"),
//             _paymentTile("Credit / Debit Card"),
//             const Spacer(),
//         ElevatedButton(
//           onPressed: () async {
//             final controller =
//             ref.read(orderControllerProvider.notifier);
//
//             await controller.placeOrder();
//
//             final state = ref.read(orderControllerProvider);
//
//             state.whenOrNull(
//               data: (_) {
//                 context.go('/order-success');
//               },
//               error: (e, _) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(e.toString())),
//                 );
//               },
//             );
//           },
//           child: const Text("Place Order"),
//         ),
//
//
//         // ElevatedButton(
//         //   onPressed: () async {
//         //     try {
//         //       final user = FirebaseAuth.instance.currentUser;
//         //
//         //       if (user == null) {
//         //         debugPrint("❌ USER NULL");
//         //         return;
//         //       }
//         //
//         //       debugPrint("🟢 USER UID: ${user.uid}");
//         //
//         //       final cartItems = ref.read(cartProvider).value ?? [];
//         //
//         //       debugPrint("🟢 CART ITEMS COUNT: ${cartItems.length}");
//         //
//         //       if (cartItems.isEmpty) {
//         //         debugPrint("❌ CART EMPTY");
//         //         return;
//         //       }
//         //
//         //       final orderItems = cartItems.map((item) {
//         //         return {
//         //           'productId': item.product.productId,
//         //           'title': item.product.title,
//         //           'price': item.product.sellingPrice,
//         //           'quantity': item.quantity,
//         //         };
//         //       }).toList();
//         //
//         //       final docRef = await FirebaseFirestore.instance
//         //           .collection('orders')
//         //           .add({
//         //         'userId': user.uid,
//         //         'totalAmount': ref.read(cartTotalProvider),
//         //         'status': 'Placed',
//         //         'createdAt': FieldValue.serverTimestamp(),
//         //         'items': orderItems,
//         //         'address': {
//         //           'name': 'Test User',
//         //           'city': 'Test City',
//         //         },
//         //       });
//         //
//         //       debugPrint("✅ ORDER CREATED: ${docRef.id}");
//         //
//         //     } catch (e, st) {
//         //       debugPrint("❌ FIRESTORE ERROR: $e");
//         //       debugPrint(st.toString());
//         //     }
//         //   },
//         //   child: const Text("DIRECT ORDER WRITE TEST"),
//         // ),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _paymentTile(String title) {
//     return ListTile(
//       leading: const Icon(Icons.radio_button_unchecked),
//       title: Text(title),
//     );
//   }
// }
