import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/product_model.dart';

class ProductRepository {
  final FirebaseFirestore firestore;
  ProductRepository(this.firestore);

  Future<List<ProductModel>> getProducts() async {
    final snapshot = await firestore
        .collection('products')
        .limit(20)
        .get();

    return snapshot.docs
        .map((e) => ProductModel.fromJson(e.data()))
        .toList();
  }

  Future<ProductModel> getProduct(int productId) async {
    final doc = await firestore
        .collection('products')
        .doc(productId.toString())
        .get();

    if (!doc.exists) {
      throw Exception('Product not found');
    }

    return ProductModel.fromJson(doc.data()!);
  }

  Future<List<ProductModel>> getSimilarProducts(
      String category,
      ) async {
    final snapshot = await firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .limit(10)
        .get();

    return snapshot.docs
        .map((e) => ProductModel.fromJson(e.data()))
        .toList();
  }
}

