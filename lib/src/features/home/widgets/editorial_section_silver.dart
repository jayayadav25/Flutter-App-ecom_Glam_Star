import 'package:flutter/material.dart';
import '../data/editorial_repository.dart';
import '../domain/entities/editorial_type.dart';
import 'editorial_container.dart';

class HomeEditorialSection extends StatelessWidget {
  final EditorialType type;

  const HomeEditorialSection({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final sections = EditorialRepository.getSections(type);
    return Column(
      children: List.generate(sections.length, (index) {
          return EditorialContainer(
            section: sections[index],
            index: index,
            type: type,
          );
        },
      ),
    );
  }
}
