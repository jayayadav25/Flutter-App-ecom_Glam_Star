class CheckoutHelpers {

  static String formatPrice(
      double value,
      ) {

    return '₹${value.toStringAsFixed(0)}';
  }
}