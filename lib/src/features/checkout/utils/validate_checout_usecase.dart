class ValidateCheckoutUsecase {
  String? call({
    required bool hasAddress,
    required bool hasCartItems,
  }) {
    if (!hasCartItems) {
      return 'Cart is empty';
    }
    if (!hasAddress) {
      return 'Please select address';
    }
    return null;
  }
}