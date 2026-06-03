import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import '../../address/provider/address_provider.dart';
import '../../cart/providers/cart_providers.dart';
import '../provider/checkout_provider.dart';
import '../provider/checkout_total_provider.dart';
import '../provider/payment_offer_provider.dart';
import '../widgets/card_payment_form.dart';
import '../widgets/checkout_button.dart';
import '../widgets/payment_method_tile.dart';
import '../widgets/payment_offer_card.dart';
import '../widgets/secure_payment_banner.dart';
import '../widgets/upi_payment_form.dart';
import '../../../core/models/payment_method_model.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final checkout = ref.watch(checkoutProvider);
    final total = ref.watch(checkoutTotalProvider);
    final offers = ref.watch(paymentOffersProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Payment',),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SecurePaymentBanner(),
              const SizedBox(height: 12),

              // Offers
              PaymentOffersCard(
                onViewAll: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30,),
                      ),
                    ),

                    builder: (_) {
                      return Padding(padding:
                        const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Available Offers',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),

                            const SizedBox(height: 20,),
                            ...offers.map((e) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 14,),

                                  padding: const EdgeInsets.all(18,),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20,),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.local_offer,
                                        color:AppColors.success,),

                                      const SizedBox(width: 14,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(e.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),

                                            const SizedBox(height: 4,),
                                            Text(e.subtitle,),
                                          ],
                                        ),
                                      ),

                                      // TextButton(
                                      //   onPressed:
                                      //       () {
                                      //
                                      //     ref
                                      //         .read(
                                      //       checkoutProvider.notifier,
                                      //     )
                                      //         .applyOffer(
                                      //       code: e.couponCode,
                                      //
                                      //       discount: e.discount,
                                      //     );
                                      //
                                      //     Navigator.pop(
                                      //       context,
                                      //     );
                                      //   },
                                      //
                                      //   child:
                                      //   Text(
                                      //     'Apply',
                                      //
                                      //     style:
                                      //     AppTextStyles.goldButtonText,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 24),

              const Text(
                'Choose Payment Method',

                style:
                AppTextStyles.titleLarge,
              ),

              const SizedBox(height: 20),

              PaymentMethodTile(
                method:
                PaymentMethods.upi,

                child:
                const UpiPaymentForm(),
              ),

              PaymentMethodTile(
                method:
                PaymentMethods.card,

                child:
                const CardPaymentForm(),
              ),

              PaymentMethodTile(
                method:
                PaymentMethods.cod,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),

      // BOTTOM BAR
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 20,),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08,),
              blurRadius: 18,
              offset: const Offset(0, -4),
            ),
          ],
        ),

        child: SafeArea(
          top: false,
          child: Row(
            children: [
              // TOTAL
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Payment',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${total.toStringAsFixed(0)}',
                      style: AppTextStyles.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // PAY BUTTON
              Expanded(
                flex: 2,
                child: CheckoutButton(
                  loading: checkout.isLoading,
                  title: 'Pay Now',
                  onTap: () async {
                    final address = ref.read(selectedAddressProvider,);
                    final cart = ref.read(cartProvider,).value ?? [];
                    if (address == null) {
                      return;
                    }
                    try {
                      ref.read(checkoutProvider.notifier,).setLoading(true,);
                      final user = FirebaseAuth.instance.currentUser;
                      if (user == null) {
                        throw Exception('User not logged in',);
                      }

                      // ITEMS
                      final items = cart.map((e) {
                        return {
                          'productId': e.productId,
                          'title': e.title,
                          'image': e.image,
                          'quantity': e.quantity,
                          'sellingPrice': e.sellingPrice,
                          'actualPrice': e.actualPrice,
                        };
                      }).toList();

                      // PRICE CALCULATIONS
                      final actualPrice = cart.fold(0.0, (sum, item,) =>
                        sum + (item.actualPrice * item.quantity),);

                      final sellingPrice = cart.fold(0.0, (sum, item,) =>
                        sum + (item.sellingPrice * item.quantity),
                      );

                      final productDiscount = actualPrice - sellingPrice;
                      final couponDiscount = checkout.couponDiscount;

                      // final offerDiscount =
                      //     checkout
                      //         .offerDiscount;

                      final shippingFee = 0.0;
                      final totalSaved = productDiscount + couponDiscount;

                      // SAVE ORDER
                        await FirebaseFirestore.instance.collection('orders',).add({
                          // USER
                          'userId': user.uid,
                          // ITEMS
                          'items': items,
                          // ADDRESS
                          'address': {
                            'name': address.fullName,
                            'phone': address.phone,
                            'city': address.city,
                            'zipCode': address.zipCode,
                            'address': address.addressLine1,
                          },

                          // PAYMENT
                          'paymentMethod': checkout.selectedPayment.title,

                          // PRICE DETAILS
                          'actualPrice': actualPrice,
                          'sellingPrice': sellingPrice,
                          'productDiscount': productDiscount,
                          'couponDiscount': couponDiscount,
                          'shippingFee': shippingFee,
                        'totalSaved': totalSaved,
                        'totalAmount': total,

                        // COUPON
                        'couponCode': checkout.couponCode,
                        // STATUS
                        'status': 'Placed',
                        'paymentStatus': 'Paid',
                        // TIMESTAMP
                        'createdAt': FieldValue.serverTimestamp(),
                      });
                      // CLEAR CART
                      await ref.read(cartProvider.notifier,).clearCart();
                      if (context.mounted) {
                        context.go('/order-success',);
                      }
                    } catch (e) {
                      if (context.mounted) {
                        context.go('/order-failed',)
                        ;}

                    } finally {
                      ref.read(checkoutProvider.notifier,).setLoading(false,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
