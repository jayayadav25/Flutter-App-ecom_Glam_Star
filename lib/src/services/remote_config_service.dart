import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfigService {
  static final FirebaseRemoteConfig _remoteConfig =
      FirebaseRemoteConfig.instance;

  static Future<void> init() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval:
          kDebugMode ? Duration.zero : const Duration(hours: 12),
        ),
      );

      await _remoteConfig.setDefaults(const {
        "show_banner": true,
        "home_experiment": false,
      });

      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      debugPrint("⚠️ RemoteConfig init failed: $e");
    }
  }

  static bool getBool(String key) => _remoteConfig.getBool(key);
  static String getString(String key) => _remoteConfig.getString(key);
}
