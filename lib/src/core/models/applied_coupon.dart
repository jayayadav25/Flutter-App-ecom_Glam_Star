class AppliedCoupon {
  final String code;
  final double discount;

  AppliedCoupon({
    required this.code,
    required this.discount,
  });

  Map<String, dynamic> toMap() => {
    'code': code,
    'discount': discount,
  };

  factory AppliedCoupon.fromMap(Map<String, dynamic> map) {
    return AppliedCoupon(
      code: map['code'],
      discount: (map['discount'] as num).toDouble(),
    );
  }
}
