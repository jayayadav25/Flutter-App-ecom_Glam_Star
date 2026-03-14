import 'package:flutter/material.dart';
import 'editorial_data.dart';
import 'reusable_widget.dart';


class EditorialSection extends StatelessWidget {
  final EditorialData section;

  const EditorialSection({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: section.title,
          subtitle: section.subtitle,
        ),
      ],
    );
  }
}

