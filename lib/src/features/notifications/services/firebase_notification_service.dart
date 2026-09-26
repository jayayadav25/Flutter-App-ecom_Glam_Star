import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'local_notification_service.dart';

class FirebaseNotificationService {
  FirebaseNotificationService._();

  static final instance =
  FirebaseNotificationService._();

  final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;

  Future<void> initialize() async {
    await requestPermission();

    await saveFCMToken();

    configureForeground();

    configureBackgroundTap();
  }

  Future<void> requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> saveFCMToken() async {
    final token =
    await _messaging.getToken();

    print(token);
  }

  void configureForeground() {
    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) async {
        await LocalNotificationService
            .instance
            .show(
          title:
          message.notification?.title ??
              '',
          body:
          message.notification?.body ??
              '',
        );
      },
    );
  }

  void configureBackgroundTap() {
    FirebaseMessaging
        .onMessageOpenedApp
        .listen(
          (message) {
        print(
          "Notification tapped",
        );
      },
    );
  }

  Future<void> saveTokenToFirestore(
      String uid,
      ) async {
    final token =
    await _messaging.getToken();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(
      {
        "fcmToken": token,
      },
      SetOptions(merge: true),
    );
  }
}