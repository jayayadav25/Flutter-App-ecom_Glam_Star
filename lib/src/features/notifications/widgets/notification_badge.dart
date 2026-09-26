import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/notification_provider.dart';

class NotificationBadge
    extends ConsumerWidget {
  const NotificationBadge({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final unreadCount =
    ref.watch(unreadCountProvider);

    return unreadCount.when(
      data: (count) {
        return Badge(
          isLabelVisible: count > 0,
          label: Text('$count'),
          child: IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
            ),
            onPressed: () {
              context.push(
                '/notifications',
              );
            },
          ),
        );
      },
      loading: () => IconButton(
        icon: const Icon(
          Icons.notifications_outlined,
        ),
        onPressed: () {},
      ),
      error: (_, __) => IconButton(
        icon: const Icon(
          Icons.notifications_outlined,
        ),
        onPressed: () {},
      ),
    );
  }
}