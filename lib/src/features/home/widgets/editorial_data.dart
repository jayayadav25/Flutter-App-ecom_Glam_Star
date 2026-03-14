import 'editorial_image_data.dart';

class EditorialData {
  final String title;
  final String subtitle;
  final List<EditorialImageData> items;

  const EditorialData({
    required this.title,
    required this.subtitle,
    required this.items,
  });
}
