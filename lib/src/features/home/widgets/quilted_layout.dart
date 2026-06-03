import 'package:flutter/material.dart';
import '../domain/entities/editorial_type.dart';
import 'editorial_data.dart';
import 'editorial_image_card.dart';

class QuiltedLayout extends StatelessWidget {

  final EditorialData section;
  final EditorialType type;

  const QuiltedLayout({
    super.key,
    required this.section,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: section.items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .72,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),

      itemBuilder: (_, index) {
        return EditorialImageCard(
          data: section.items[index],
          borderRadius: 30,
          type: type,
        );
      },
    );
  }
}