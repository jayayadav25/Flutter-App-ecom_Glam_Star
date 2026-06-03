import '../../../core/models/order_model.dart';

import '../../../features/cart/providers/cart_providers.dart';

class ReorderUsecase {

  Future<void> reorder({
    required OrderModel order,
    required dynamic cartNotifier,
  }) async {

    for (final item in order.items) {
      await cartNotifier.addToCart(
        productId:
        item['productId'],
        title: item['title'],
        image: item['image'],
        price: item['price'],
        quantity: item['quantity'],
      );
    }
  }
}