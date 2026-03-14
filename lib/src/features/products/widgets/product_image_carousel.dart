import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/models/product_model.dart';

class ProductImageCarousel extends StatefulWidget {
  final ProductModel product;

  const ProductImageCarousel({super.key, required this.product});

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.product.images;

    return Stack(
      children: [
        SizedBox(
          height: 520,
          child: PageView.builder(
            itemCount: images.length,
            onPageChanged: (i) => setState(() => index = i),
            itemBuilder: (_, i) {
              final img = images[i];

              return Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: img.url,
                    fit: BoxFit.cover,
                    //width: double.infinity,
                  ),

                  // Info overlay image
                  if (img.type == "info_overlay")
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        width: 260,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: _highlights(widget.product),
                      ),
                    ),
                ],
              );
            },
          ),
        ),

        // DOt indicator
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
                  (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: index == i ? 10 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: index == i ? Colors.white : Colors.white54,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _highlights(ProductModel p) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _item("Color", p.baseColour),
        _item("Season", p.season),
        _item("Usage", p.usage),
        _item("Pack", "1 Pair"),
        _item("Care", "Machine Wash"),
      ],
    );
  }

  Widget _item(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        "$label: $value",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
