import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics;

  AnalyticsService(this._analytics);

  // Generic event logger
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }


  // Log screen views
  Future<void> logScreenView({
    required String screenName,
  }) async {
    await _analytics.logScreenView(screenName: screenName);
  }

  // Log product viewed
  Future<void> logProductViewed({
    required String productId,
    required String productName,
    required double price,
  }) async {
    await _analytics.logEvent(
      name: 'product_viewed',
      parameters: {
        'product_id': productId,
        'product_name': productName,
        'price': price,
      },
    );
  }

  // Log item added to cart
  Future<void> logAddToCart({
    required String productId,
    required String productName,
    required double price,
  }) async {
    await _analytics.logAddToCart(
      items: [
        AnalyticsEventItem(
          itemId: productId,
          itemName: productName,
          price: price,
          quantity: 1,
        ),
      ],
      value: price,
      currency: 'INR',
    );
  }

  // Log item removed from cart
  Future<void> logRemoveFromCart({
    required String productId,
    required String productName,
  }) async {
    await _analytics.logEvent(
      name: 'remove_from_cart',
      parameters: {
        'product_id': productId,
        'product_name': productName,
      },
    );
  }

  // Log wishlist add
  Future<void> logAddToWishlist({
    required String productId,
    required String productName,
  }) async {
    await _analytics.logEvent(
      name: 'add_to_wishlist',
      parameters: {
        'product_id': productId,
        'product_name': productName,
      },
    );
  }

  // Log wishlist remove
  Future<void> logRemoveFromWishlist({
    required String productId,
    required String productName,
  }) async {
    await _analytics.logEvent(
      name: 'remove_from_wishlist',
      parameters: {
        'product_id': productId,
        'product_name': productName,
      },
    );
  }

  // Log search queries
  Future<void> logSearch(String query) async {
    await _analytics.logSearch(searchTerm: query);
  }

  // Log checkout start
  Future<void> logBeginCheckout(double totalPrice) async {
    await _analytics.logBeginCheckout(
      value: totalPrice,
      currency: 'INR',
    );
  }

  // Log purchase complete
  Future<void> logPurchase({
    required double totalPrice,
    required List<Map<String, dynamic>> items,
  }) async {
    await _analytics.logPurchase(
      value: totalPrice,
      currency: 'INR',
      transactionId: DateTime.now().millisecondsSinceEpoch.toString(),
      items: items
          .map(
            (item) => AnalyticsEventItem(
          itemId: item['id'],
          itemName: item['name'],
          price: item['price'],
          quantity: item['quantity'],
        ),
      )
          .toList(),
    );
  }
}
