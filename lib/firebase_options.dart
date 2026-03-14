
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCnQpWSy8r8c0lW8VeBZH7V_6wkNZPteog',
    appId: '1:831856509099:web:4662cd5f31bcfa3bd7f7ee',
    messagingSenderId: '831856509099',
    projectId: 'trendora-228a2',
    authDomain: 'trendora-228a2.firebaseapp.com',
    storageBucket: 'trendora-228a2.firebasestorage.app',
    measurementId: 'G-G6TLFB2YSL',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5oApOU9X6Oukc_JhEPTVKI9efjLwLUNU',
    appId: '1:831856509099:ios:12b7ef20414306b7d7f7ee',
    messagingSenderId: '831856509099',
    projectId: 'trendora-228a2',
    storageBucket: 'trendora-228a2.firebasestorage.app',
    iosClientId: '831856509099-vlochopi2j2e5oogm5biv38opbhdam02.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseMasteryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC5oApOU9X6Oukc_JhEPTVKI9efjLwLUNU',
    appId: '1:831856509099:ios:12b7ef20414306b7d7f7ee',
    messagingSenderId: '831856509099',
    projectId: 'trendora-228a2',
    storageBucket: 'trendora-228a2.firebasestorage.app',
    iosClientId: '831856509099-vlochopi2j2e5oogm5biv38opbhdam02.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseMasteryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCnQpWSy8r8c0lW8VeBZH7V_6wkNZPteog',
    appId: '1:831856509099:web:d834255b65752de0d7f7ee',
    messagingSenderId: '831856509099',
    projectId: 'trendora-228a2',
    authDomain: 'trendora-228a2.firebaseapp.com',
    storageBucket: 'trendora-228a2.firebasestorage.app',
    measurementId: 'G-KECEGYZNL1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAuSiUsA6GkWjNgrwOLof_yPpj5nrYpEng',
    appId: '1:831856509099:android:c99d42f4130d7415d7f7ee',
    messagingSenderId: '831856509099',
    projectId: 'trendora-228a2',
    storageBucket: 'trendora-228a2.firebasestorage.app',
  );

}