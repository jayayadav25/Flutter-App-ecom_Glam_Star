import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationRemoteDataSource {NotificationRemoteDataSource(this._firestore,);
  final FirebaseFirestore _firestore;

  Future<void> saveNotification({
    required String title,
    required String body,
    String route = '',
  }) async {

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('notifications')
        .add({
      'title': title,
      'body': body,
      'route': route,
      'isRead': false,
      'createdAt':
      FieldValue.serverTimestamp(),
    });
  }
}