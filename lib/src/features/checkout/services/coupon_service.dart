class CouponService {

  static double validateCoupon(
      String code,
      ) {

    switch (code.toUpperCase()) {

      case 'SAVE100':
        return 100;

      case 'FIRST20':
        return 200;

      default:
        return 0;
    }
  }
}