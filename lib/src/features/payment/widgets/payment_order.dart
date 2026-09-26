class PaymentOrder {
  final bool success;
  final String orderId;
  final double amount;
  final String currency;
  final String receipt;

  const PaymentOrder({
    required this.success,
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.receipt,
  });
}