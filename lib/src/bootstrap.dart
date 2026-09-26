import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../firebase_options.dart';
import 'app/utils/constants.dart';
import 'core/data/json_product_list.dart';
import 'features/notifications/services/background_handler.dart';
import 'features/notifications/services/notification_service.dart';
import 'services/json_import_service.dart';
import 'services/remote_config_service.dart';
import 'services/analytics_service.dart';
import 'services/firestore_service.dart';
import 'services/storage_service.dart';
import 'core/providers/firebase_providers.dart';

// Set true only if you want to skip App Check in dev
const bool SKIP_APPCHECK_DEV = false;

Future<void> bootstrap(Widget app) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase init
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  print(
    'FIREBASE PROJECT => ${Firebase.app().options.projectId}',
  );

  print(
    'APP ID => ${Firebase.app().options.appId}',
  );

  FirebaseMessaging.onBackgroundMessage(
    firebaseBackgroundHandler,
  );

  await NotificationService
      .instance
      .initialize();

  // Firestore cache
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  // App Check
  if (SKIP_APPCHECK_DEV || kDebugMode) {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
    );

    final token = await FirebaseAppCheck.instance.getToken();
    debugPrint('🔑 AppCheck Debug Token: $token');
  } else {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
    );
  }

  // Hive
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.wishlistBox);
  await Hive.openBox(AppConstants.cartBox);

  // Remote Config (STATIC)
  await RemoteConfigService.init();

  // Optional one-time JSON import
  await JsonImportService().importJsonToFirestore(jsonProductsList);

  // Dependency overrides
  final container = ProviderContainer();

  runApp(
    ProviderScope(
      overrides: [
        analyticsProvider.overrideWithValue(
          AnalyticsService(container.read(analyticsFirebaseProvider)),
        ),
        firestoreServiceProvider.overrideWithValue(
          FirestoreService(container.read(firestoreFirebaseProvider)),
        ),
        storageServiceProvider.overrideWithValue(
          StorageService(storage: container.read(storageFirebaseProvider)),
        ),
      ],
      child: app,
    ),
  );
}