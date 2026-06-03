import 'package:intl/intl.dart';

class DeliveryService {

  static String estimateDelivery() {

    final date =
    DateTime.now().add(
      const Duration(days: 4),
    );

    return DateFormat(
      'EEE, dd MMM',
    ).format(date);
  }
}