import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../common/styles/colors.dart';
import '../../../core/models/product_model.dart';

class ProductImageCarousel extends StatefulWidget {
  final ProductModel product;

  const ProductImageCarousel({super.key, required this.product,});

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.product.images;

    return Column(
      children: [
        Hero(
          tag: 'product_${widget.product.productId}',
          child: CarouselSlider.builder(
            itemCount: images.length,
            options: CarouselOptions(
              height: 500,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
            itemBuilder: (_, index, __) {
              return Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: images.length,
                    options: CarouselOptions(
                      height: 500,
                      viewportFraction: 1,
                      enlargeCenterPage: false,

                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    ),

                    itemBuilder: (_, index, __) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: images[index].url,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),

                  // INDICATOR
                  Positioned(
                    bottom: 18,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: activeIndex,
                        count: images.length,
                        effect: ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          spacing: 6,
                          activeDotColor: AppColors.primaryBlack,
                          dotColor: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}