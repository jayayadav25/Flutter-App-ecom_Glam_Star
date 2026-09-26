import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'local_notification_service.dart';
import 'notification_navigation.dart';

class NotificationService {NotificationService._();
  static final instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  Future<void> initialize() async {
    await LocalNotificationService.instance.initialize();
    await _requestPermission();
    await saveNotificationToken();
  //  await _saveToken();
    _configureForeground();
    _configureTapEvents();
  }

  Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }
Future<void> saveNotificationToken() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;
  final token = await _messaging.getToken();
  print("FCM TOKEN => $token");
  if (token == null) return;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .set(
    {
      'fcmToken': token,
      'updatedAt': FieldValue.serverTimestamp(),
    },
    SetOptions(
      merge: true,
    ),
  );
}
  // Future<void> _saveToken() async {
  //   final token = await _messaging.getToken();
  //   print('FCM TOKEN => $token');
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user == null || token == null) {
  //     return;
  //   }
  //
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user.uid)
  //       .set(
  //     {
  //       'fcmToken': token,
  //       'updatedAt':
  //       FieldValue.serverTimestamp(),
  //     },
  //     SetOptions(
  //       merge: true,
  //     ),
  //   );
  // }

  void _configureForeground() {

    FirebaseMessaging.onMessage.listen(
          (message) async {

        final title =
            message.notification?.title ??
                '';

        final body =
            message.notification?.body ??
                '';

        await LocalNotificationService
            .instance
            .show(
          title: title,
          body: body,
        );
      },
    );
  }

  void _configureTapEvents() {

    FirebaseMessaging.onMessageOpenedApp
        .listen(
      NotificationNavigation.handle,
    );

    _messaging.getInitialMessage().then(
          (message) {

        if (message != null) {
          NotificationNavigation.handle(
            message,
          );
        }
      },
    );
  }

  Future<void> refreshToken() async {

    _messaging.onTokenRefresh.listen(
          (newToken) async {

        final user =
            FirebaseAuth.instance.currentUser;

        if (user == null) return;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'fcmToken': newToken,
        });
      },
    );
  }

  Future<void> saveNotificationLocally({
    required String title,
    required String body,
    String route = '',
  }) async {

    final user =
        FirebaseAuth.instance.currentUser;

    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('notifications')
        .add({
      'title': title,
      'body': body,
      'route': route,
      'isRead': false,
      'createdAt':
      FieldValue.serverTimestamp(),
    });
  }

Future<void> subscribeToNotifications() async {

  await FirebaseMessaging.instance
      .subscribeToTopic(
    'general',
  );
}

Future<void> unsubscribeFromNotifications() async {

  await FirebaseMessaging.instance
      .unsubscribeFromTopic(
    'general',
  );
}
}