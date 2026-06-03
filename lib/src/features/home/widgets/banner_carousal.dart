import 'dart:async';
import 'package:flutter/material.dart';
import '../data/banner_repository.dart';
import '../domain/entities/banner_type.dart';
import 'banner_card.dart';
import 'banner_data.dart';

class BannerCarousel extends StatefulWidget {
  final BannerType type;

  const BannerCarousel({
    super.key,
    required this.type,
  });

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late final PageController _controller;
  int _currentIndex = 0;
  late List<BannerData> banners;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: .94,
    );
    _loadBanners();
    _startAutoScroll();
  }

  @override
  void didUpdateWidget(covariant BannerCarousel oldWidget,) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.type != widget.type) {
      _currentIndex = 0;
      banners = BannerRepository.getBanners(
            widget.type,
          );
      _controller.jumpToPage(0);
      setState(() {});
    }
  }

  void _loadBanners() {
    banners = BannerRepository.getBanners(
      widget.type,);
  }
  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 4), (_) {
        if (!mounted || banners.isEmpty) return;
        _currentIndex = (_currentIndex + 1) % banners.length;
        _controller.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 650,),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // BANNER
        AspectRatio(
          aspectRatio: 16 / 9,
          child: PageView.builder(
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return AnimatedScale(
                duration: const Duration(milliseconds: 350,),
                scale: _currentIndex == index ? 1 : .96,
                child: PremiumBannerCard(
                  data: banners[index],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 14),

        // INDICATOR
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (index) {
              final active = _currentIndex == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 350,),
                margin: const EdgeInsets.symmetric(horizontal: 4,),
                width: active ? 24 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: active ? Colors.black : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}