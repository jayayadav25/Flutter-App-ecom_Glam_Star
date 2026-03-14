class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;
  final String segment;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.segment,
  });

  // firestore factory (fixes error)
  factory CategoryModel.fromFirestore(
      String id,
      Map<String, dynamic> data,
      ) {
    return CategoryModel(
      id: id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      segment: data['segment'] ?? '',
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'imageUrl': imageUrl,
  //     'segment': segment,
  //   };
  // }
}
