import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../widgets/app_Button.dart';
import '../../../core/models/bank_offer_model.dart';
import '../../cart/providers/cart_final_provider.dart';
import '../../cart/providers/cart_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../cart/widgets/cart_address_card.dart';
import '../../orders/data/order_controller.dart';
import '../widgets/netbanking_offer.dart';
import '../widgets/payment_method_tile.dart';
import '../widgets/card_payment_form.dart';
import '../widgets/payment_offer_tile.dart';
import '../widgets/upi_payment_section.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(cartTotalProvider);
    final finalAmount = ref.watch(finalPayableAmountProvider);



    final offers = [
      BankOfferModel(
        bankName: "HDFC Bank",
        offerText: "10% Instant Discount",
        discount: 500,
        minOrder: 3000,
        maxUsage: 1,
        validTill: "31 Dec 2025",
        logoUrl:
        "HDFC BANK",
      ),
      BankOfferModel(
        bankName: "ICICI Bank",
        offerText: "₹750 Cashback",
        discount: 750,
        minOrder: 5000,
        maxUsage: 1,
        validTill: "30 Nov 2025",
        logoUrl:
        "ICICI BANK",
      ),
      BankOfferModel(
        bankName: "SBI Bank",
        offerText: "₹750 Cashback",
        discount: 750,
        minOrder: 5000,
        maxUsage: 1,
        validTill: "30 Nov 2025",
        logoUrl:
        "SBI BANK",
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Payment  ₹$finalAmount")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text("Payment Offers", style:TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
          SizedBox(height:15),
          PaymentOfferTile(offers: offers),

          const SizedBox(height: 20),
          Text("Select payment method", style:TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
          const SizedBox(height: 15),
          /// PAYMENT METHODS
          PaymentMethodTile(
            title: "UPI",
            icon: Icons.account_balance_wallet_outlined,
            child: UpiPaymentSection(
              finalAmount: finalAmount,
              onPay: (method, upiId) async {
                final controller =
                ref.read(orderControllerProvider.notifier);

                await controller.placeOrder(
                  paymentMethod: method,
                  totalAmount: finalAmount,
                );

                final state = ref.read(orderControllerProvider);

                state.whenOrNull(
                  data: (_) => context.go('/order-success'),
                  error: (e, _) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  },
                );
              },
            ),
          ),



          PaymentMethodTile(
            title: "Credit / Debit Card",
            icon: Icons.credit_card,
            child: CardPaymentForm(
              finalAmount: finalAmount,
              onPay: () async {
                final controller =
                ref.read(orderControllerProvider.notifier);

                await controller.placeOrder(
                  paymentMethod: "Card",
                  totalAmount: finalAmount,
                );

                final state = ref.read(orderControllerProvider);

                state.whenOrNull(
                  data: (_) => context.go('/order-success'),
                  error: (e, _) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  },
                );
              },
            ),
          ),


          PaymentMethodTile(
            title: "Net Banking",
            icon: Icons.account_balance,
            child: NetBankingSection(
              finalAmount: finalAmount,
              onPay: (bankName) async {
                final controller =
                ref.read(orderControllerProvider.notifier);

                await controller.placeOrder(
                  paymentMethod: "Net Banking ($bankName)",
                  totalAmount: finalAmount,
                );

                final state = ref.read(orderControllerProvider);

                state.whenOrNull(
                  data: (_) => context.go('/order-success'),
                  error: (e, _) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  },
                );
              },
            ),
          ),


          PaymentMethodTile(
            title: "Cash on Delivery",
            icon: Icons.money,
            child: AppButton(
              onPressed: () async {
                final controller =
                ref.read(orderControllerProvider.notifier);

                await controller.placeOrder(
                  paymentMethod: "Cash on Delivery", // or Card / UPI
                  totalAmount: ref.read(cartTotalProvider),
                );

                final state = ref.read(orderControllerProvider);

                state.whenOrNull(
                  data: (_) {
                    context.go('/order-success');
                  },
                  error: (e, _) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  },
                );
              },
             text:"Place Order",
            ),
          ),

          const SizedBox(height: 20),

          // Order info
          Text("Order information", style:TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
          const SizedBox(height: 15),
          AddressCard()

          // Price details
         // PriceDetailsSection(total: total),

        //  const SizedBox(height: 16),

        ],
      ),
    );
  }
}
