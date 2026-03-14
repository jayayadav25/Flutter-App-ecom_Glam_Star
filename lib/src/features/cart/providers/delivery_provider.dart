import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/delivery_eta.dart';

final deliveryEtaProvider = Provider<DeliveryETA>((ref) {
  final now = DateTime.now();

  final deliveryDate = now.add(const Duration(days: 4));

  return DeliveryETA(
    label: "Delivery by ${deliveryDate.day}/${deliveryDate.month}",
    date: deliveryDate,
  );
});
