import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/product_model.dart';
import '../../../core/adaptors/firestore_product_adapter.dart';

class ProductRepository {
  final _db = FirebaseFirestore.instance;

  Stream<List<ProductModel>> getAllProducts() {
    return _db.collection('products').snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => FirestoreProductAdapter.fromDoc(doc))
          .toList(),
    );
  }

  Stream<ProductModel?> getProductById(String id) {
    return _db.collection('products').doc(id).snapshots().map((doc) {
      if (!doc.exists) return null;
      return FirestoreProductAdapter.fromDoc(doc);
    });
  }
}
