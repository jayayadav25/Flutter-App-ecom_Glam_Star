// lib/widgets/safe_network_image.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../src/core/providers/firebase_providers.dart';
import 'images.dart' show AppImage; // adjust import path for your storageServiceProvider

/// Widget that accepts either:
///  - a storage fullPath (e.g. 'products/.../hero.jpg'), OR
///  - a download URL (https://...)
/// It resolves to a download URL using StorageService.safeGetDownloadUrl and shows
/// a placeholder if not found.
class SafeNetworkImage extends ConsumerWidget {
  final String? storageOrUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const SafeNetworkImage({
    Key? key,
    required this.storageOrUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = ref.read(storageServiceProvider);
    if (storageOrUrl == null || storageOrUrl!.trim().isEmpty) {
      return placeholder ??
          Container(
            height: height,
            width: width,
            color: Colors.grey[200],
            child: const Center(child: Icon(Icons.image_not_supported)),
          );
    }

    return FutureBuilder<String?>(
      future: storage.safeGetDownloadUrl(storageOrUrl!.trim()),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return placeholder ??
              Container(
                height: height,
                width: width,
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator()),
              );
        }
        final url = snap.data;
        if (url == null || url.isEmpty) {
          return errorWidget ??
              Container(
                height: height,
                width: width,
                color: Colors.grey[200],
                child: const Center(child: Icon(Icons.broken_image)),
              );
        }
        return Image.network(
           url,
          fit: BoxFit.cover,
          height: height,
          width: width,
        );


      },
    );
  }
}
