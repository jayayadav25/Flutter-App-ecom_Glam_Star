import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../widgets/app_Button.dart';
import '../../../core/models/applied_coupon.dart';
import '../providers/cart_providers.dart';
import '../providers/cart_selected_total_provider.dart';
import '../providers/cart_selection_provider.dart';
import '../providers/coupon_providers.dart';
import '../widgets/cart_address_card.dart';
import '../widgets/delivery_eta_widget.dart';
import '../widgets/price_detail_card.dart';
import '../widgets/saved_for_late_section.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final cartAsync = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);
    final couponAsync = ref.watch(appliedCouponProvider);
    final coupon = ref.watch(appliedCouponProvider);
    final couponDiscount = coupon?.discount ?? 0;
    final selectedTotal = ref.watch(selectedCartTotalProvider);
    final selectedMrpTotal = ref.watch(selectedMrpTotalProvider);
    final selectedSellingTotal = ref.watch(selectedSellingTotalProvider);
    final cart = ref.watch(cartProvider).value ?? [];
    final selectedIds = ref.watch(cartSelectionProvider);





    return Scaffold(
      body: cartAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }

          final double mrpTotal = items.fold(
            0.0,
                (sum, item) => sum + item.mrpTotal,
          );

          final double sellingTotal = items.fold(
            0.0,
                (sum, item) => sum + item.sellingTotal,
          );

          final double orderTotal = sellingTotal - couponDiscount;
         // final orderTotal = total - couponDiscount;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const AddressCard(),
              const SizedBox(height: 15,),
              const DeliveryEtaWidget(),
              SavedForLaterSection(),

              // Cart items
              ...items.map((item) {
                final isSelected =
                selectedIds.contains(item.product.productId);

                return AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.push(
                                  '/product-detail/${item.product.productId}',
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  item.product.images.first.url,
                                  width: 70,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            Positioned(
                              top: -10,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 1.4,
                                ),
                                checkColor: Colors.black,
                                fillColor: MaterialStateProperty.all(
                                  Colors.white,
                                ),
                                value: isSelected,
                                onChanged: (_) {
                                  ref
                                      .read(cartSelectionProvider.notifier)
                                      .toggle(item.product.productId.toString());
                                },
                              ),
                            ),
                          ],
                        ),


                        const SizedBox(width: 12),

                        // Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.product.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.cancel,
                                      color: Colors.black26,
                                    ),
                                    onPressed: () {
                                      ref
                                          .read(cartProvider.notifier)
                                          .removeFromCart(
                                        item.product.productId.toString(),
                                      );
                                    },
                                  ),
                                ],
                              ),

                              const SizedBox(height: 6),

                              Text(
                                "₹${item.product.sellingPrice}",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(height: 8),

                              // Quantity control
                              Row(
                                children: [
                                  _qtyButton(
                                    icon: Icons.remove,
                                    onTap: () {
                                      ref
                                          .read(cartProvider.notifier)
                                          .decrement(item.product.productId.toString());
                                    },
                                  ),
                                  const SizedBox(width: 12),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 250),
                                    child: Text(
                                      "${item.quantity}",
                                      key: ValueKey(item.quantity),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  _qtyButton(
                                    icon: Icons.add,
                                    onTap: () {
                                      ref
                                          .read(cartProvider.notifier)
                                          .increment(item.product.productId.toString());
                                    },
                                  ),
                                ],
                              ),

                              const SizedBox(height: 6),
                              const Divider(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),


              // Apply Coupon
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black, width: 0.1),
                ),
                child: ListTile(
                  leading: const Icon(Icons.local_offer_outlined),
                  title: Text(
                    coupon == null
                        ? "Apply Coupon"
                        : "Coupon Applied: ${coupon.code}",
                  ),
                  subtitle: coupon != null
                      ? Text("You saved ₹${coupon.discount}")
                      : null,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final result =
                    await context.push<Map<String, dynamic>>('/coupons');

                    if (result != null) {
                      ref.read(appliedCouponProvider.notifier).applyCoupon(
                        AppliedCoupon(
                          code: result['code'],
                          discount: result['discount'],
                        ),
                      );
                    }
                  },
                ),
              ),

              const SizedBox(height:15),
              // Price Details
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black, width: 0.2),),
                child:Padding(
                  padding: const EdgeInsets.all(16),
                  child: PriceDetailsCard(
                    mrpTotal: selectedMrpTotal,
                    sellingTotal: selectedSellingTotal,
                    couponDiscount: couponDiscount,
                  ),
                ),
              ),
            ],
          );
        },
      ),

      bottomNavigationBar: cartAsync.maybeWhen(
        data: (items) => items.isEmpty
            ? null
            : Container(
          padding: const EdgeInsets.only(left:20, top:16,bottom:16, right:20),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  "₹${(selectedTotal - couponDiscount).toStringAsFixed(0)}",
                  key: ValueKey(selectedTotal - couponDiscount),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                child: AppButton(
                  text:"Proceed to Buy",
                  onPressed: () {
                    final selected = ref.read(cartSelectionProvider);

                    if (selected.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select at least one item"),
                        ),
                      );
                      return;
                    }
                    context.push('/checkout');
                  },
                ),
              ),

            ],
          ),
        ),
        orElse: () => null,
      ),
    );
  }

  Widget _qtyButton(
      {required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }

}
