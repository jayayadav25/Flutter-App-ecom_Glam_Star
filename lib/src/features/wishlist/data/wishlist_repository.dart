// import 'package:hive_flutter/hive_flutter.dart';
// import '../../../app/utils/constants.dart';
// import '../../../core/models/product_model.dart';
// import '../../../core/models/product_model_mapper.dart';
//
// class WishlistRepository {
//   late Box _box;
//
//   Future<void> init() async {
//     _box = Hive.isBoxOpen(AppConstants.wishlistBox)
//         ? Hive.box(AppConstants.wishlistBox)
//         : await Hive.openBox(AppConstants.wishlistBox);
//   }
//
//   List<ProductModel> getAll() {
//     final List<ProductModel> valid = [];
//
//     for (final e in _box.values) {
//       try {
//         final map = Map<String, dynamic>.from(e);
//         final product = ProductModelMapper.fromMap(map);
//
//         //  Invalid product - Delete
//         if (product.productId <= 0 || product.sellingPrice <= 0) {
//           _box.delete(product.productId);
//           continue;
//         }
//
//         valid.add(product);
//       } catch (_) {
//         //  Corrupted entry
//         _box.clear();
//       }
//     }
//
//     return valid;
//   }
//
//
//   bool contains(String productId) {
//     return _box.containsKey(productId);
//   }
//
//   Future<void> toggle(ProductModel product) async {
//     if (_box.containsKey(product.productId)) {
//       await _box.delete(product.productId);
//     } else {
//       await _box.put(product.productId, product.toMap());
//     }
//   }
//
//   Future<void> remove(String productId) async {
//     await _box.delete(productId);
//   }
// }
//
//
