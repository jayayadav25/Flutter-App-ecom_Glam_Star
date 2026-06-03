import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import '../providers/size_provider.dart';

class SizeSelector extends ConsumerWidget {
  const SizeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedSizeProvider);

    final sizes = ['S', 'M', 'L', 'XL'];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Size',
            style: AppTextStyles.smallTitle
          ),
          const SizedBox(height: 10),
          Row(
            children: sizes.map((size) {
              final isSelected = selected == size;
              return GestureDetector(
                onTap: () {
                  ref.read(selectedSizeProvider.notifier).state = size;
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryBlack
                        : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryBlack
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    size,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : AppColors.primaryBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}