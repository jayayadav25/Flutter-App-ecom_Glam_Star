import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentSessionState {
  final String? selectedMethod;
  final String upiId;
  final String cardNumber;
  final String expiry;
  final String cvv;
  final String holder;

  const PaymentSessionState({
    this.selectedMethod,
    this.upiId = '',
    this.cardNumber = '',
    this.expiry = '',
    this.cvv = '',
    this.holder = '',
  });

  PaymentSessionState copyWith({
    String? selectedMethod,
    String? upiId,
    String? cardNumber,
    String? expiry,
    String? cvv,
    String? holder,
  }) {

    return PaymentSessionState(

      selectedMethod: selectedMethod ?? this.selectedMethod,
      upiId: upiId ?? this.upiId,
      cardNumber: cardNumber ?? this.cardNumber,
      expiry: expiry ?? this.expiry,
      cvv: cvv ?? this.cvv,
      holder: holder ?? this.holder,
    );
  }
}

class PaymentSessionNotifier extends StateNotifier<PaymentSessionState> {
  PaymentSessionNotifier() : super(
    const PaymentSessionState(),
  );

  // SELECT UPI
  void selectUpi() {
    state = state.copyWith(
      selectedMethod: 'upi',
      // CLEAR CARD DATA
      cardNumber: '',
      expiry: '',
      cvv: '',
      holder: '',
    );
  }

  // SELECT CARD
  void selectCard() {
    state = state.copyWith(
      selectedMethod: 'card',
      // CLEAR UPI DATA
      upiId: '',
    );
  }

  // SELECT COD
  void selectCOD() {
    state = state.copyWith(
      selectedMethod: 'cod',
      // CLEAR ALL
      upiId: '',
      cardNumber: '',
      expiry: '',
      cvv: '',
      holder: '',
    );
  }

  // SAVE UPI
  void setUpi(String value) {
    state = state.copyWith(
      upiId: value,
    );
  }

  // SAVE CARD
  void setCard({
    required String number,
    required String expiry,
    required String cvv,
    required String holder,
  }) {

    state = state.copyWith(
      cardNumber: number,
      expiry: expiry,
      cvv: cvv,
      holder: holder,
    );
  }
}

final paymentSessionProvider = StateNotifierProvider<PaymentSessionNotifier, PaymentSessionState>((ref) {
    return PaymentSessionNotifier();
  },
);

final selectedPaymentMethodProvider = StateProvider<String?>((ref) => null,);