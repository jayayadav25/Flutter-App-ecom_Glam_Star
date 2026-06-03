import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../common/styles/colors.dart';
import '../../address/provider/address_provider.dart';
import '../../cart/providers/cart_providers.dart';
import '../provider/checkout_provider.dart';
import '../provider/checkout_total_provider.dart';
import '../provider/delivery_provider.dart';
import '../provider/derived_provider.dart';
import '../widgets/add_address_card.dart';
import '../widgets/address_section.dart';
import '../widgets/checkout_button_bar.dart';
import '../widgets/checkout_header.dart';
import '../widgets/delivery_timeline.dart';
import '../widgets/order_item_section.dart';
import '../widgets/price_card.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final cart = ref.watch(cartProvider).value ?? [];
    final addressAsync = ref.watch(addressProvider);
    final selectedAddress = ref.watch(selectedAddressProvider);
    final shipping = ref.watch(shippingProvider);
    final total = ref.watch(checkoutTotalProvider);
    final checkout = ref.watch(checkoutProvider);
    final deliveryDate = ref.watch(deliveryProvider);

    // Actual Price
    final actualPrice = cart.fold(0.0, (sum, item) =>
      sum + (item.actualPrice * item.quantity),);

    // Selling Price
    final sellingPrice = cart.fold(0.0, (sum, item) =>
      sum + (item.sellingPrice * item.quantity),);

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      bottomNavigationBar: cart.isEmpty ? null : CheckoutBottomBar(
        total: total,
        onTap: () {
          if (selectedAddress == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Please select address',
                ),
              ),
            );
            return;
          }
          context.push('/payment');
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const CheckoutHeader(),
              const SizedBox(height: 12),
              // Address
              addressAsync.when(
                data: (addresses) {
                  if (addresses.isEmpty) {
                    return AddAddressCard(
                      onTap: () {
                        context.push(
                          '/addresses/add',
                        );
                      },
                    );
                  }

                  if (selectedAddress == null) {
                    Future.microtask(() {
                      ref.read(selectedAddressProvider.notifier,).state = addresses.first;});
                  }
                  return AddressSection(
                    address: selectedAddress ?? addresses.first,
                    onChange: () {
                      context.push('/addresses',);
                    },
                  );
                },

                loading: () => const Center(
                  child: CircularProgressIndicator(),),
                error: (_, __) =>
                const Text('Failed to load address',),
              ),

              const SizedBox(height: 10),

              // Delivery
              DeliveryTimeline(
                deliveryDate: deliveryDate,
              ),

              const SizedBox(height: 10),

              // Order Items
              OrderItemsSection(
                items: cart,
                deliveryDate: deliveryDate,
              ),
              const SizedBox(height: 10),

              // // Coupon
              // if (checkout.couponCode == null)
              //   CouponSection(
              //     onApply: (code) {
              //       final discount = CouponService.validateCoupon(code,);
              //       if (discount == 0) {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           const SnackBar(
              //             content: Text(
              //               'Invalid coupon',
              //             ),
              //           ),
              //         );
              //
              //         return;
              //       }
              //
              //       ref.read(checkoutProvider.notifier,).applyCoupon(
              //         code: code,
              //         discount: discount,
              //       );
              //     },
              //   ),
              //
              // if (checkout.couponCode != null)
              //   AppliedCouponCard(
              //     code: checkout.couponCode!,
              //     onRemove: () {
              //       ref.read(checkoutProvider.notifier,).removeCoupon();},
              //   ),
              //
              // const SizedBox(height: 12),

              // Price Card
              PriceCard(
                actualPrice: actualPrice,
                sellingPrice: sellingPrice,
                shippingFee: shipping,
                couponDiscount: checkout.couponDiscount,
                total: total,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}