import '../../../core/models/checkout_price_model.dart';

class PricingService {
  static CheckoutPriceModel calculate({
    required double subtotal,
    required double discount,
  }) {

    double shippingFee = 49;
    if (subtotal > 2000) {
      shippingFee = 0;
    }

    final total = subtotal + shippingFee - discount;

    return CheckoutPriceModel(
      subtotal: subtotal,
      shippingFee: shippingFee,
      discount: discount,
      total: total,
    );
  }
}