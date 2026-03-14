class CouponModel {
  final String code;
  final String title;
  final String description;
  final double discount;
  final Duration expiry;

  CouponModel({
    required this.code,
    required this.title,
    required this.description,
    required this.discount,
    required this.expiry,
  });
}
