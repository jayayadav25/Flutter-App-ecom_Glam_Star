import 'package:flutter/material.dart';
import '../domain/entities/editorial_type.dart';
import 'editorial_data.dart';
import 'editorial_image_card.dart';

class CarouselLayout extends StatelessWidget {

  final EditorialData section;
  final EditorialType type;

  const CarouselLayout({
    super.key,
    required this.section,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: .86,
        ),

        itemCount: section.items.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: EditorialImageCard(
              data: section.items[index],
              borderRadius: 30,
                type: type,
            ),
          );
        },
      ),
    );
  }
}