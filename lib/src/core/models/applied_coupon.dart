class AppliedCouponModel {
  final String code;
  final double discount;

  const AppliedCouponModel({
    required this.code,
    required this.discount,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'discount': discount,
    };
  }

  factory AppliedCouponModel.fromMap(Map<String, dynamic> map) {
    return AppliedCouponModel(
      code: map['code'],
      discount: (map['discount'] as num).toDouble(),
    );
  }
}