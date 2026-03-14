import 'package:firebase_mastery_app/src/features/home/presentation/screen/sub_category_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/sub_category_type.dart';
import '../../providers/sub_category_provider.dart';
import '../../data/repositories/sub_category_repository.dart';

class SubCategoryScreen extends ConsumerWidget {
  final SubCategoryType type;

  const SubCategoryScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subCategories = SubCategoryRepository.getSubCategories(type);

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: subCategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final sub = subCategories[i];

          return GestureDetector(
            onTap: () {
              ref.read(selectedSubCategoryProvider.notifier).state = sub.value;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SubCategoryProductsScreen(),
                ),
              );
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage(sub.image),
                ),
                const SizedBox(height: 6),
                Text(
                  sub.label,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
