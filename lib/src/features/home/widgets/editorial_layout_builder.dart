import 'package:firebase_mastery_app/src/features/home/widgets/quilted_layout.dart';
import 'package:flutter/material.dart';
import '../domain/entities/editorial_layout_type.dart';
import '../domain/entities/editorial_type.dart';
import 'carousal_layout.dart';
import 'editorial_data.dart';
import 'horizontal_layout.dart';

class EditorialLayoutBuilder extends StatelessWidget {

  final EditorialData section;
  final EditorialType type;

  const EditorialLayoutBuilder({
    super.key,
    required this.section,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    switch (section.layout) {
      case EditorialLayoutType.horizontal:
        return HorizontalLayout(
          section: section,
          type: type,
        );

      case EditorialLayoutType.carousel:
        return CarouselLayout(
            section: section,
          type: type,
        );

      case EditorialLayoutType.quilted:
        return QuiltedLayout(
            section: section,
          type: type,
        );
    }
  }
}