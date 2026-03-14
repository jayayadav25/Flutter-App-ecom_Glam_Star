import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/product_repository.dart';
import '../../../core/models/product_model.dart';

final productRepositoryProvider =
Provider((ref) => ProductRepository());

final allProductsProvider =
StreamProvider<List<ProductModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('products')
      .limit(20) // prevent OOM
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      return ProductModel.fromJson(doc.data());
    }).toList();
  });
});


final productByIdProvider =
StreamProvider.family<ProductModel?, String>((ref, id) {
  return ref.read(productRepositoryProvider).getProductById(id);
});
