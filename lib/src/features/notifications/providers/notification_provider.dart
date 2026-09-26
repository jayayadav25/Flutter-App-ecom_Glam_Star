import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/notification_repository.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
    return NotificationRepository(
      FirebaseFirestore.instance,
    );
  },
);

final notificationEnabledProvider = StateNotifierProvider<NotificationSettingsNotifier, bool>((ref) =>
    NotificationSettingsNotifier(),
);

class NotificationSettingsNotifier extends StateNotifier<bool> {
  NotificationSettingsNotifier() : super(true);
  Future<void> setEnabled(bool value,) async {
    state = value;
  }
}

final notificationsProvider = StreamProvider.autoDispose((ref) {
    return ref.watch(notificationRepositoryProvider,).getNotifications();
  },
);

final latestNotificationsProvider = StreamProvider.autoDispose((ref) {
    return ref.watch(notificationRepositoryProvider,).getLatestNotifications();
  },
);

final unreadCountProvider = StreamProvider.autoDispose<int>((ref) {
    return ref.watch(notificationRepositoryProvider,).getUnreadCount();
  },

);





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../core/models/app_notification_model.dart';
// import '../data/notification_repository.dart';
//
//
// /// Repository Provider
// final notificationRepositoryProvider =
// Provider<NotificationRepository>(
//       (ref) => NotificationRepository(
//     FirebaseFirestore.instance,
//   ),
// );
//
// /// Notification Stream
// final notificationsProvider =
// StreamProvider<List<AppNotification>>(
//       (ref) {
//     return ref
//         .watch(notificationRepositoryProvider)
//         .getNotifications();
//   },
// );
//
// /// Unread Count
// final unreadCountProvider =
// StreamProvider<int>(
//       (ref) {
//     return ref
//         .watch(notificationRepositoryProvider)
//         .getUnreadCount();
//   },
// );
//
// /// Latest Notifications (Top 5)
// final latestNotificationsProvider =
// StreamProvider<List<AppNotification>>(
//       (ref) {
//     return ref
//         .watch(notificationRepositoryProvider)
//         .getLatestNotifications();
//   },
// );