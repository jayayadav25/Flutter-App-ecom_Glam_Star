extension PriceExtension on double {

  String get inr {

    return '₹${toStringAsFixed(0)}';
  }
}