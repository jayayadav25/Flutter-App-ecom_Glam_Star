import 'package:flutter/material.dart';
import '../domain/entities/editorial_type.dart';
import 'editorial_data.dart';
import 'editorial_image_card.dart';

class HorizontalLayout extends StatelessWidget {
  final EditorialData section;
  final EditorialType type;

  const HorizontalLayout({
    super.key,
    required this.section,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 18,),
        physics: const BouncingScrollPhysics(),
        itemCount: section.items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, index) {
          final item = section.items[index];
          return SizedBox(
            width: 190,
            child: EditorialImageCard(
              data: item,
              borderRadius: 32,
              type: type,
            ),
          );
        },
      ),
    );
  }

  EditorialType _getType(String category) {

    switch (category) {

      case 'men':
        return EditorialType.men;

      case 'women':
        return EditorialType.women;

      case 'kids':
        return EditorialType.kids;

      default:
        return EditorialType.home;
    }
  }
}