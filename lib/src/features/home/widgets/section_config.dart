import '../domain/entities/editorial_layout_type.dart';

class SectionConfig {
  final EditorialLayoutType layout;
  final bool showViewAll;
  final bool autoScroll;
  final double height;

  const SectionConfig({
    required this.layout,
    required this.showViewAll,
    required this.autoScroll,
    required this.height,
  });
}