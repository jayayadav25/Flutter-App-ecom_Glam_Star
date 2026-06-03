import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../usecases/reorder_usecases.dart';

final reorderUsecaseProvider = Provider<ReorderUsecase>((ref) {
  return ReorderUsecase();
});