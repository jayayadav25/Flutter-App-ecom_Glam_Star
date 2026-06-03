import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/product_model.dart';
import '../data/product_repository.dart';


final firestoreProvider = Provider((ref) {
  return FirebaseFirestore.instance;
});

final productRepositoryProvider = Provider((ref) {
  return ProductRepository(
    ref.read(firestoreProvider),
  );
});

final productsProvider = FutureProvider<List<ProductModel>>(
      (ref) async {
    return ref
        .read(productRepositoryProvider)
        .getProducts();
  },
);

final productDetailProvider = FutureProvider.family<ProductModel, int>(
      (ref, productId) async {
    return ref.read(productRepositoryProvider).getProduct(productId);
  },
);
