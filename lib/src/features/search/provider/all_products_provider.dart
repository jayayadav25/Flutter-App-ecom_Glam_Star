import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/light_product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final allProductsProvider = FutureProvider<List<LightProductModel>>((ref,) async {
  final snapshot = await FirebaseFirestore
      .instance
      .collection('products_light')
      .get();

  return snapshot.docs.map((doc) =>
      LightProductModel.fromJson(doc.data(),),).toList();
});