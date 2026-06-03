import '../../../core/models/product_model.dart';

abstract class HomeRepository {
  Future<List<ProductModel>> fetchLatestProducts({int limit,});
  Future<List<ProductModel>> fetchByCategory(String category);
}