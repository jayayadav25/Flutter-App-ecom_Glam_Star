import 'package:flutter/material.dart';
import '../domain/entities/editorial_layout_type.dart';
import 'editorial_image_data.dart';

class EditorialData {

  final String title;
  final String subtitle;

  final EditorialLayoutType layout;

  final List<Color> colors;

  final String category;

  final List<EditorialImageData> items;

  const EditorialData({
    required this.title,
    required this.subtitle,
    required this.layout,
    required this.colors,
    required this.category,
    required this.items,
  });
}
