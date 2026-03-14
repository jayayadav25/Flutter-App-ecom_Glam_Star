import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/entities/banner_type.dart';
import '../../data/repositories/banner_repository.dart';
import '../../widgets/banner_card.dart';
import '../../widgets/banner_data.dart';

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
  final PageController _controller = PageController();
  int _currentIndex = 0;
  late List<BannerData> banners;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadBanners();
    _startAutoScroll();
  }

  // Key fix
  @override
  void didUpdateWidget(covariant BannerCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.type != widget.type) {
      _currentIndex = 0;
      _controller.jumpToPage(0);

      setState(() {
        banners = BannerRepository.getBanners(widget.type);
      });
    }
  }

  void _loadBanners() {
    banners = BannerRepository.getBanners(widget.type);
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted || banners.isEmpty) return;

      _currentIndex = (_currentIndex + 1) % banners.length;
      _controller.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
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
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (_, index) {
              return BannerCard(data: banners[index]);
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? Colors.black
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
