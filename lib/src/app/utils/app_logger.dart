// lib/src/utils/app_logger.dart
// Centralized logger for Trendora App

import 'dart:developer' as developer;

class AppLogger {
  static void info(String message) {
    developer.log(message, name: 'INFO');
  }

  static void debug(String message) {
    developer.log(message, name: 'DEBUG');
  }

  static void warning(String message) {
    developer.log(message, name: 'WARNING');
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: 'ERROR',
      error: error,
      stackTrace: stackTrace,
    );
  }
}