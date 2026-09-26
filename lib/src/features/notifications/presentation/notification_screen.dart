import 'package:firebase_mastery_app/src/common/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/app_notification_model.dart';
import '../providers/notification_provider.dart';
import '../widgets/notification_tile.dart';

class NotificationScreen
    extends ConsumerWidget {

  const NotificationScreen({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {

    final notifications =
    ref.watch(
      notificationsProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
        ),
        backgroundColor: AppColors.scaffold,
      ),
      body: notifications.when(
        data: (notifications) {
          if(notifications.isEmpty) {
            return const Center(
              child: Text(
                'No Notifications',
              ),
            );
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder:
                (context, index) {
                  final notification = notifications[index];
              return NotificationTile(
                notification: notification,
                onTap: () async {
                  await ref.read(notificationRepositoryProvider,).markAsRead(notification.id,);

                  if (notification.route.isNotEmpty) {
                    context.push(
                      notification.route,
                    );
                  }
                },
              );
            },
          );
        },

        error:
            (e, s) => Center(
          child: Text(
            e.toString(),
          ),
        ),

        loading:
            () => const Center(
          child:
          CircularProgressIndicator(),
        ),
      ),
    );
  }
}