import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../services/analytics_service.dart';
import '../../services/firestore_service.dart';
import '../../services/remote_config_service.dart';
import '../../services/storage_service.dart';

// Firestore instance
final firestoreFirebaseProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// Storage instance
final storageFirebaseProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});

// Remote Config instance
final remoteConfigFirebaseProvider = Provider<FirebaseRemoteConfig>((ref) {
  return FirebaseRemoteConfig.instance;
});

// Analytics instance
final analyticsFirebaseProvider = Provider<FirebaseAnalytics>((ref) {
  return FirebaseAnalytics.instance;
});

// SERVICES

final remoteConfigProvider = Provider<RemoteConfigService>((ref) {
  throw UnimplementedError(
      'RemoteConfigService is not initialized yet. It must be overridden in bootstrap.dart');
});

final analyticsProvider = Provider<AnalyticsService>((ref) {
  throw UnimplementedError(
      'AnalyticsService is not initialized yet. It must be overridden in bootstrap.dart');
});

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  throw UnimplementedError(
      'FirestoreService is not initialized yet. It must be overridden in bootstrap.dart');
});

final storageServiceProvider = Provider<StorageService>((ref) {
  throw UnimplementedError(
      'StorageService is not initialized yet. It must be overridden in bootstrap.dart');
});
