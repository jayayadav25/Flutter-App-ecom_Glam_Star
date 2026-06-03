import 'dart:ui';
import 'package:flutter/material.dart';
import '../domain/entities/editorial_type.dart';
import 'editorial_data.dart';
import 'editorial_header.dart';
import 'editorial_layout_builder.dart';

class EditorialContainer extends StatelessWidget {

  final EditorialData section;
  final EditorialType type;
  final int index;

  const EditorialContainer({
    super.key,
    required this.section,
    required this.type,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8,),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _gradients(index),
        ),

        borderRadius:
        BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, 10),
            color: Colors.black.withOpacity(.06),
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10,),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                EditorialHeader(section: section),
                const SizedBox(height: 14),
                EditorialLayoutBuilder(
                  section: section,
                  type: type,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Color> _gradients(int index) {

    final gradients = [

      [
        const Color(0xFFFAEBAF),
        const Color(0xC3F1E3CE),
      ],

      // [
      //   const Color(0xFFFFF3E8),
      //   const Color(0xFFFFE0CC),
      // ],

      [
        const Color(0xFFEAF4FF),
        const Color(0xFFD6E8FF),
      ],

      [
        const Color(0xFFFFE5EC),
        const Color(0xFFFFD6E0),
      ],

      [
        const Color(0xFFF6F0FF),
        const Color(0xFFE5DBFF),
      ],
    ];

    return gradients[index % gradients.length];
  }
}