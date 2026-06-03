import '../../../core/models/checkout_price_model.dart';
import '../services/pricing_service.dart';

class CalculateCheckoutUsecase {

  CheckoutPriceModel call({
    required double subtotal,
    required double discount,
  }) {

    return PricingService.calculate(
      subtotal: subtotal,
      discount: discount,
    );
  }
}