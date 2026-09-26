import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(
    RemoteMessage message,
    ) async {
  await Firebase.initializeApp();

  print(
    'Background Notification: ${message.notification?.title}',
  );
}