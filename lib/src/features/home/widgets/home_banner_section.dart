import 'package:flutter/material.dart';
import '../domain/entities/banner_type.dart';
import 'banner_carousal.dart';

class HomeBannerSection extends StatelessWidget {
  final BannerType type;

  const HomeBannerSection({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: BannerCarousel(type: type),
    );
  }
}