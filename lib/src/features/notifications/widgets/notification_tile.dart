import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/app_notification_model.dart';
import '../providers/notification_provider.dart';

class NotificationTile extends ConsumerWidget {
  final AppNotification notification;
  final VoidCallback onTap;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  String getNotificationTime(
      Timestamp timestamp,
      ) {
    final createdAt = timestamp.toDate();

    final difference =
    DateTime.now().difference(createdAt);

    if (difference.inMinutes < 1) {
      return "Just now";
    }

    if (difference.inHours < 1) {
      return "${difference.inMinutes} min ago";
    }

    if (difference.inDays < 1) {
      return "${difference.inHours} hr ago";
    }

    if (difference.inDays < 7) {
      return "${difference.inDays} day ago";
    }

    return "${createdAt.day}/${createdAt.month}/${createdAt.year}";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUnread = !notification.isRead;

    IconData icon = Icons.notifications_outlined;
    Color iconColor = Colors.blue;

    if (notification.title.contains('Order')) {
      icon = Icons.shopping_bag_outlined;
      iconColor = Colors.green;
    }

    if (notification.title.contains('Shipped')) {
      icon = Icons.local_shipping_outlined;
      iconColor = Colors.orange;
    }

    if (notification.title.contains('Offer')) {
      icon = Icons.local_offer_outlined;
      iconColor = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        // onTap: () async {
        //   await ref.read(notificationRepositoryProvider)
        //       .markAsRead(notification.id);
        //   if (notification.title.contains('Order')) {
        //     context.push('/orders');
        //     return;
        //   }
        //   if (notification.title.contains('Shipped')) {
        //     context.push('/orders');
        //     return;
        //   }
        //   if (notification.title.contains('Offer')) {
        //     context.push('/offers');
        //     return;
        //   }
        //   if (notification.route.isNotEmpty) {
        //     context.push(notification.route);
        //   }
        // },
        //onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isUnread ? const Color(0xffFFF8F3) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                spreadRadius: 1,
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor,),
              ),

              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(notification.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        if (isUnread)
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(notification.body,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration:
                          BoxDecoration(
                            color: iconColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(30),),
                          child: Text(notification.title,
                            style: TextStyle(
                              color: iconColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          getNotificationTime(
                            notification.createdAt,
                          ),
                          style: TextStyle(
                            color:
                            Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}