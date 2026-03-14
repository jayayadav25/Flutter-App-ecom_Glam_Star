
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../firebase_options.dart';
import 'app/utils/constants.dart';
import 'core/data/json_product_list.dart';
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



















// // src/bootstrap.dart  (replace existing function)
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_mastery_app/src/services/delete_duplicate_products.dart';
// import 'package:firebase_mastery_app/src/services/json_import_service.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import '../firebase_options.dart';
// import 'core/data/json_product_list.dart';
// import 'core/providers/firebase_providers.dart';
// import 'services/remote_config_service.dart';
// import 'services/analytics_service.dart';
// import 'services/firestore_service.dart';
// import 'services/storage_service.dart';
// import 'app/utils/constants.dart';
//
// /// Set this to true if you want to skip App Check activation while developing quickly.
// /// You can also set this through environment/build-time flags if you prefer.
// const bool SKIP_APPCHECK_DEV = false;
//
// Future<void> bootstrap(Future<Widget> Function() builder) async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   FirebaseFirestore.instance.settings = const Settings(
//     persistenceEnabled: true,
//     cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
//   );
//
//   // if (SKIP_APPCHECK_DEV || kDebugMode) {
//   //   await FirebaseAppCheck.instance.activate(
//   //     androidProvider: AndroidProvider.debug,
//   //   );
//   //   debugPrint('🔥 AppCheck debug provider ACTIVATED');
//   // } else {
//   //   await FirebaseAppCheck.instance.activate(
//   //     androidProvider: AndroidProvider.playIntegrity,
//   //   );
//   //   debugPrint('🔥 AppCheck real provider ACTIVATED');
//   // }
//
//   if (SKIP_APPCHECK_DEV || kDebugMode) {
//     await FirebaseAppCheck.instance.activate(
//       androidProvider: AndroidProvider.debug,
//     );
//     debugPrint('🔥 AppCheck debug provider ACTIVATED');
//
//     // Print App Check debug token for console registration
//     final debugToken = await FirebaseAppCheck.instance.getToken();
//     debugPrint('🔑 AppCheck Debug Token: $debugToken');
//     print('AppCheck Debug Token: $debugToken (Register this token in Firebase Console > App Check > Debug Tokens)');
//   } else {
//     await FirebaseAppCheck.instance.activate(
//       androidProvider: AndroidProvider.playIntegrity,
//     );
//     debugPrint('🔥 AppCheck real provider ACTIVATED');
//   }
//
//   // 51342F92-F40A-43F8-BCEC-6FB2A423B0E9 appcheck token
//
//
//   // Initialize Hive
//   await Hive.initFlutter();
//   await Hive.openBox(AppConstants.wishlistBox);
//   await Hive.openBox(AppConstants.cartBox);
//
//   final container = ProviderContainer();
//
//   final remoteConfigService =
//   RemoteConfigService(container.read(remoteConfigFirebaseProvider));
//   await remoteConfigService.init();
//
//   await RemoteConfigService.init();
//
//   final analyticsService =
//   AnalyticsService(container.read(analyticsFirebaseProvider));
//
//   final firestoreService =
//   FirestoreService(container.read(firestoreFirebaseProvider));
//
//   final storageService =
//   StorageService(storage: container.read(storageFirebaseProvider));
//
//   await JsonImportService().importJsonToFirestore(jsonProductsList);
//   // await deleteDuplicateProductsByTitle(
//   //   'Solid Men Multicolor Track Pants',
//   // );
//
//   container.dispose();
//
//   runApp(
//     ProviderScope(
//       overrides: [
//         remoteConfigProvider.overrideWithValue(remoteConfigService),
//         analyticsProvider.overrideWithValue(analyticsService),
//         firestoreServiceProvider.overrideWithValue(firestoreService),
//         storageServiceProvider.overrideWithValue(storageService),
//       ],
//       child: await builder(),
//     ),
//   );
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
