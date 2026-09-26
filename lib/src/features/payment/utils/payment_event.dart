abstract class PaymentEvent {}

class PaymentSuccessEvent extends PaymentEvent {
  final String paymentId;
  final String orderId;
  final String signature;

  PaymentSuccessEvent({
    required this.paymentId,
    required this.orderId,
    required this.signature,
  });
}

class PaymentErrorEvent extends PaymentEvent {
  final int? code;
  final String message;

  PaymentErrorEvent({
    this.code,
    required this.message,
  });
}

class ExternalWalletEvent extends PaymentEvent {
  final String walletName;

  ExternalWalletEvent({
    required this.walletName,
  });
}