import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/editorial_type.dart';

final editorialFilterProvider = StateProvider<EditorialType>(
      (ref) => EditorialType.home,);