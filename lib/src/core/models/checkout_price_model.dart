class CheckoutPriceModel {
  final double subtotal;
  final double shippingFee;
  final double discount;
  final double total;

  const CheckoutPriceModel({
    required this.subtotal,
    required this.shippingFee,
    required this.discount,
    required this.total,
  });
}