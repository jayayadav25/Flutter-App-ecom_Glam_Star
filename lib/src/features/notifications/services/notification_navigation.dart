import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';

class NotificationNavigation {

  static GoRouter? router;

  static void initialize(
      GoRouter appRouter,
      ) {
    router = appRouter;
  }

  static void handle(
      RemoteMessage message,
      ) {

    final route =
    message.data['route'];

    if (route == null) return;

    router?.push(route);
  }
}