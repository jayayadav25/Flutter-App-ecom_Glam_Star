import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/delivery_eta.dart';

final deliveryEtaProvider = Provider<DeliveryEtaModel>((ref) {
  final now = DateTime.now();

  final deliveryDate = now.add(
    const Duration(days: 4),
  );

  return DeliveryEtaModel(
    label:
    'Delivery by ${deliveryDate.day}/${deliveryDate.month}',
    date: deliveryDate,
  );
});
