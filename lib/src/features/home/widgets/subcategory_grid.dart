import 'package:firebase_mastery_app/src/features/home/widgets/subcategory_list.dart';
import 'package:flutter/material.dart';
import '../domain/entities/sub_category_type.dart';

class SubCategorySection extends StatelessWidget {
  final SubCategoryType type;

  const SubCategorySection({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text('Shop By Category',),
          ),
          const SizedBox(height: 14),
          PremiumSubCategoryList(type: type),
        ],
      ),
    );
  }
}