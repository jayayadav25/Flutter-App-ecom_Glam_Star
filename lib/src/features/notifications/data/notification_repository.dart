import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/models/app_notification_model.dart';

class NotificationRepository {NotificationRepository(this._firestore,);
  final FirebaseFirestore _firestore;

  String get _uid => FirebaseAuth.instance.currentUser!.uid;

  CollectionReference<Map<String, dynamic>>
  get _notificationRef => _firestore.collection('users')
          .doc(_uid).collection('notifications');

  /// All Notifications
  Stream<List<AppNotification>> getNotifications() {
    return _notificationRef
        .orderBy('createdAt', descending: true,)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(
            AppNotification.fromFirestore,).toList(),
    );
  }

  /// Top 5 Notifications
  Stream<List<AppNotification>> getLatestNotifications() {
    return _notificationRef.orderBy('createdAt', descending: true,)
        .limit(5)
        .snapshots().map((snapshot) => snapshot.docs.map(
            AppNotification.fromFirestore,).toList(),
    );
  }

  /// Unread Count
  Stream<int> getUnreadCount() {
    return _notificationRef.where('isRead', isEqualTo: false,)
        .snapshots().map(
          (snapshot) => snapshot.docs.length,
    );
  }

  /// Mark Single Notification Read
  Future<void> markAsRead(String notificationId,) async {
    await _notificationRef.doc(notificationId).update({
      'isRead': true,
    });
  }

  /// Mark All Read
  Future<void> markAllAsRead() async {
    final snapshot = await _notificationRef.where(
      'isRead',
      isEqualTo: false,
    ).get();

    final batch = _firestore.batch();
    for (final doc in snapshot.docs) {
      batch.update(
        doc.reference,
        {
          'isRead': true,
        },
      );
    }

    await batch.commit();
  }

  /// Delete Notification
  Future<void> deleteNotification(String notificationId,) async {
    await _notificationRef.doc(notificationId).delete();
  }

  /// Save Notification
  Future<void> saveNotification({
    required String title,
    required String body,
    required String route,
  }) async {
    await _notificationRef.add({
      'title': title,
      'body': body,
      'route': route,
      'isRead': false,
      'createdAt':
      FieldValue.serverTimestamp(),
    });
  }
}