import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderFilterProvider = StateProvider<String>((ref) => 'All',);