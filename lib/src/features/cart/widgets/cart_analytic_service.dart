import 'package:firebase_analytics/firebase_analytics.dart';

class CartAnalyticsService {
  final FirebaseAnalytics analytics;

  CartAnalyticsService(this.analytics);

  Future<void> logAddToCart({
    required String productId,
  }) async {
    await analytics.logAddToCart(
      items: [
        AnalyticsEventItem(
          itemId: productId,
        )
      ],
    );
  }

  Future<void> logBeginCheckout(double total) async {
    await analytics.logBeginCheckout(
      value: total,
      currency: 'INR',
    );
  }
}