import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/light_product_model.dart';
import 'home_provider.dart';

final selectedSubCategoryProvider = StateProvider<String?>((ref) => null);

final subCategoryProductsProvider =
FutureProvider<List<LightProductModel>>((ref) async {
  final category = ref.watch(homeTabProvider).name; // women / men / kids
  final subCategory = ref.watch(selectedSubCategoryProvider);

  if (subCategory == null) return [];

  final snap = await FirebaseFirestore.instance
      .collection('products_light')
      .where('category', isEqualTo: category)
      .where('sub_category', isEqualTo: subCategory)
      .limit(30)
      .get();

  return snap.docs
      .map((e) => LightProductModel.fromJson(e.data()))
      .toList();
});
