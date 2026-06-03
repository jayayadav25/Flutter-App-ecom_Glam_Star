
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/checkout_state_model.dart';
import '../../../core/models/payment_method_model.dart';

class CheckoutNotifier extends Notifier<CheckoutState> {

  @override
  CheckoutState build() {
    return CheckoutState(
      isLoading: false,
      selectedPayment: PaymentMethods.cod,
      couponCode: null,
      couponDiscount: 0,
    );
  }

  void selectPayment(PaymentMethodModel payment,) {

    state = state.copyWith(
      selectedPayment: payment,
    );
  }

  Future<void> applyCoupon({
    required String code,
    required double discount,
  }) async {

    state = state.copyWith(
      couponCode: code,
      couponDiscount: discount,
    );
  }

  void removeCoupon() {
    state = state.copyWith(
      couponCode: null,
      couponDiscount: 0,
    );
  }

  void setLoading(bool value) {
    state = state.copyWith(
      isLoading: value,
    );
  }

  void reset() {
    state = CheckoutState(
      isLoading: false,
      selectedPayment: PaymentMethods.cod,
      couponCode: null,
      couponDiscount: 0,
    );
  }
}

final checkoutProvider = NotifierProvider<CheckoutNotifier, CheckoutState>(CheckoutNotifier.new,);