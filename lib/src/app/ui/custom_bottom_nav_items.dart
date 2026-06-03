import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/styles/colors.dart';

class CustomBottomNavItem extends ConsumerWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const CustomBottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250,),
          padding: const EdgeInsets.symmetric(vertical: 10,),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.softGold.withOpacity(0.14) : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,
                color: isSelected ? AppColors.softGold : Colors.grey, size: 24,),
              const SizedBox(height: 4),
              Text(label,
                style: TextStyle(fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? AppColors.softGold
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}