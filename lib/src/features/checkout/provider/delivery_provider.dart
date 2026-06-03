import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/deliver_service.dart';


final deliveryProvider = Provider<String>((ref) {
  return DeliveryService.estimateDelivery();
});