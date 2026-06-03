import 'payment_method_model.dart';

class CheckoutState {
  final bool isLoading;
  final PaymentMethodModel selectedPayment;
  final String? couponCode;
  final double couponDiscount;

  const CheckoutState({
    required this.isLoading,
    required this.selectedPayment,
    required this.couponCode,
    required this.couponDiscount,
  });

  CheckoutState copyWith({
    bool? isLoading,
    PaymentMethodModel? selectedPayment,
    String? couponCode,
    double? couponDiscount,
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
      selectedPayment:
      selectedPayment ?? this.selectedPayment,
      couponCode: couponCode ?? this.couponCode,
      couponDiscount:
      couponDiscount ?? this.couponDiscount,
    );
  }
}