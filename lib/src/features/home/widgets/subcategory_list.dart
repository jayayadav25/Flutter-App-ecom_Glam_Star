import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/styles/colors.dart';
import '../data/sub_category_repository.dart';
import '../domain/entities/sub_category_type.dart';
import '../presentation/screen/sub_category_product_screen.dart';
import '../providers/sub_category_provider.dart';

class PremiumSubCategoryList extends ConsumerWidget {
  final SubCategoryType type;

  const PremiumSubCategoryList({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subCategories = SubCategoryRepository.getSubCategories(type);

    return SizedBox(
      height: 125,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        itemCount: subCategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, index) {
          final item = subCategories[index];

          return GestureDetector(
            onTap: () {
              ref.read(selectedSubCategoryProvider.notifier).state =
                  item.value;
              print("Selected SubCategory: ${item.value}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SubCategoryProductsScreen(),
                ),
              );
            },
            child: SizedBox(
              width: 85,
              child: Column(
                children: [
                  Container(
                    width: 74,
                    height: 74,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.softGold,
                          AppColors.primaryBlack,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.softGold.withOpacity(0.20),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          item.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    item.label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}