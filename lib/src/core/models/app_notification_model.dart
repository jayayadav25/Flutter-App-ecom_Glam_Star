import 'package:cloud_firestore/cloud_firestore.dart';

class AppNotification {
  final String id;
  final String title;
  final String body;
  final String route;
  final bool isRead;
  final Timestamp createdAt;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.route,
    required this.isRead,
    required this.createdAt,
  });

  factory AppNotification.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>>
      doc,
      ) {
    final data = doc.data();

    return AppNotification(
      id: doc.id,
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      route: data['route'] ?? '',
      isRead: data['isRead'] ?? false,
      createdAt:
      data['createdAt'] ??
          Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'route': route,
      'isRead': isRead,
      'createdAt': createdAt,
    };
  }
}