class PaymentVerification {
  final String paymentId;
  final String orderId;
  final bool verified;

  const PaymentVerification({
    required this.paymentId,
    required this.orderId,
    required this.verified,
  });
}