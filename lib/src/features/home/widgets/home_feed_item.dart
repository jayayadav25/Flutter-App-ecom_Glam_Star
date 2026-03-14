import '../domain/entities/home_feed_type.dart';

class HomeFeedItem<T> {
  final HomeFeedType type;
  final T data;

  const HomeFeedItem({
    required this.type,
    required this.data,
  });
}
