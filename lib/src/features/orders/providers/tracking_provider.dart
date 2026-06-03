
import 'package:flutter_riverpod/flutter_riverpod.dart';

final trackingStepsProvider = Provider<List<String>>((ref) {
  return [
    'Order Placed',
    'Packed',
    'Shipped',
    'Out for Delivery',
    'Delivered',
  ];
});