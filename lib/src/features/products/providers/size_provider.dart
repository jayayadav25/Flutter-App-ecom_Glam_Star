import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedSizeProvider = StateProvider<String>((ref) {
  return 'M';
});