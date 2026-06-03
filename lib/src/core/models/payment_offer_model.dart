
class PaymentOfferModel {

  final String title;
  final String subtitle;
  final String couponCode;
  final double discount;

  const PaymentOfferModel({
    required this.title,
    required this.subtitle,
    required this.couponCode,
    required this.discount,
  });
}