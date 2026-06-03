class DeliveryEtaHelper {

  static String getDeliveryText({
    required String title,
    required String productId,
  }) {

    final lowerTitle = title.toLowerCase();
    int minDays = 3;
    int maxDays = 4;

    // Cosmetics
    if (
    lowerTitle.contains('lipstick') ||
        lowerTitle.contains('foundation') ||
        lowerTitle.contains('serum') ||
        lowerTitle.contains('makeup') ||
        lowerTitle.contains('cream') ||
        lowerTitle.contains('cosmetic')
    ) {

      minDays = 2;
      maxDays = 3;
    }

    // Accessories
    else if (
    lowerTitle.contains('watch') ||
        lowerTitle.contains('ring') ||
        lowerTitle.contains('bracelet') ||
        lowerTitle.contains('necklace') ||
        lowerTitle.contains('bag')
    ) {

      minDays = 4;
      maxDays = 5;
    }

    final randomDays = minDays + (productId.hashCode.abs() % (maxDays - minDays + 1));

    final deliveryDate = DateTime.now().add(
      Duration(days: randomDays),
    );

    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return 'Delivery by '
          '${deliveryDate.day} '
          '${months[deliveryDate.month - 1]}';
  }
}