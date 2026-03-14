import '../../../../core/models/product_model.dart';
import '../../datasources/home_firestore_source.dart';
import 'home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeFirestoreSource source;

  HomeRepositoryImpl(this.source);

  @override
  Future<List<ProductModel>> fetchLatestProducts({int limit = 20}) {
    return source.fetchLatest(limit);
  }

  @override
  Future<List<ProductModel>> fetchByCategory(String category) {
    return source.fetchByCategory(category);
  }
}

