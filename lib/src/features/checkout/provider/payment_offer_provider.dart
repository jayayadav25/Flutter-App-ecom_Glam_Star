import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/payment_offer_model.dart';

final paymentOffersProvider = Provider<List<PaymentOfferModel>>((ref) {
  return [
    const PaymentOfferModel(
      title: '10% Instant Discount',
      subtitle: 'On HDFC Credit Cards',
      couponCode: 'HDFC10',
      discount: 500,
    ),

    const PaymentOfferModel(
      title: 'Flat ₹300 OFF',
      subtitle: 'On UPI Payments',
      couponCode: 'UPI300',
      discount: 300,
    ),

    const PaymentOfferModel(
      title: '15% Cashback',
      subtitle: 'Wallet Cashback Offer',
      couponCode: 'CASH15',
      discount: 200,
    ),
  ];
});