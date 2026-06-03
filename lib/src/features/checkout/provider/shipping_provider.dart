import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'subtotal_provider.dart';

final shippingProvider = Provider<double>((ref) {
  final subtotal = ref.watch(subtotalProvider);
  if (subtotal > 2000) {
    return 0;
  }

  return 49;
});