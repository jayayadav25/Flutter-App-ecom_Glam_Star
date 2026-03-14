// lib/src/widgets/app_cached_image.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCachedImage extends StatelessWidget {
  final String url;
  final BoxFit fit;

  const AppCachedImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return const Center(child: Icon(Icons.image_not_supported));
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 200),
      placeholder: (_, __) =>
      const Center(child: CircularProgressIndicator(strokeWidth: 1.5)),
      errorWidget: (_, error, __) {
        debugPrint("❌ IMAGE ERROR = $error");
        debugPrint("❌ URL = $url");
        return const Icon(Icons.broken_image, size: 40);
      },
      memCacheWidth: 600, // 🔥 VERY IMPORTANT
    );
  }
}
