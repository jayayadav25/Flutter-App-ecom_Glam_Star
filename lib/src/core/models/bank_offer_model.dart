class BankOfferModel {
  final String bankName;
  final String offerText;
  final int discount;
  final int minOrder;
  final int maxUsage;
  final String validTill;
  final String logoUrl;

  BankOfferModel({
    required this.bankName,
    required this.offerText,
    required this.discount,
    required this.minOrder,
    required this.maxUsage,
    required this.validTill,
    required this.logoUrl,
  });
}
