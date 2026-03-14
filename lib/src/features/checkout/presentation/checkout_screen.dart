import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../widgets/app_Button.dart';
import '../../address/provider/address_provider.dart';
import '../../cart/providers/cart_providers.dart';
import '../widgets/address_card.dart';
import '../widgets/order_item_tile.dart';
import '../widgets/price_summary_card.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressAsync = ref.watch(addressProvider);
    final cart = ref.watch(cartProvider).value ?? [];

    final mrpTotal =
    cart.fold<double>(0, (sum, item) => sum + item.mrpTotal);
    final sellingTotal =
    cart.fold<double>(0, (sum, item) => sum + item.sellingTotal);

    final couponDiscount = 0.0;
    final completedOrders = 2;

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Address
          addressAsync.when(
            data: (addresses) {
              if (addresses.isEmpty) {
                return TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Add Address"),
                  onPressed: () => context.push('/add-address'),
                );
              }

              final selected =
              ref.watch(selectedAddressProvider);

              //Auto Selection (Delayed)
              if (selected == null) {
                final autoSelect = addresses.firstWhere(
                      (a) => a.isDefault,
                  orElse: () => addresses.first,
                );

                Future.microtask(() {
                  ref
                      .read(selectedAddressProvider.notifier)
                      .state = autoSelect;
                });
              }

              final currentAddress =
                  ref.watch(selectedAddressProvider) ??
                      addresses.first;

              return AddressCard(
                address: currentAddress,
                onChange: () => context.push('/address-list'),
              );
            },
            loading: () =>
            const Center(child: CircularProgressIndicator()),
            error: (_, __) =>
            const Text("Failed to load address"),
          ),

          const SizedBox(height: 16),

          // Price Summary
          PriceSummaryCard(
            mrpTotal: mrpTotal,
            sellingTotal: sellingTotal,
            couponDiscount: couponDiscount,
            completedOrders: completedOrders,
          ),

          const SizedBox(height: 16),

          // Items
          ...cart.map(
                (item) => OrderItemTile(
              imageUrl: item.product.images.first.url,
              title: item.product.title,
            ),
          ),

          const SizedBox(height: 24),

          // Proceed
          AppButton(
            text: "Proceed to Pay",
            onPressed: () {
              final address =
              ref.read(selectedAddressProvider);

              if (address == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please select an address"),
                  ),
                );
                return;
              }

              context.push('/checkout/payment');
            },
          ),
        ],
      ),
    );
  }
}
