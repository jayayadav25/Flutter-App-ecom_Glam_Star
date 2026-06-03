import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';
import '../providers/home_provider.dart';

class HomeTabBar extends ConsumerWidget {
  const HomeTabBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final selected = ref.watch(homeTabProvider);
    return SizedBox(
      height: 44,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        children: [
          _tab(
            ref,
            selected,
            HomeTab.home,
            'Home',
            Icons.home_outlined,
          ),

          _tab(
            ref,
            selected,
            HomeTab.women,
            'Women',
            Icons.face_3_outlined,
          ),

          _tab(
            ref,
            selected,
            HomeTab.men,
            'Men',
            Icons.face_6_outlined,
          ),

          _tab(
            ref,
            selected,
            HomeTab.kids,
            'Kids',
            Icons.child_friendly_outlined,
          ),
        ],
      ),
    );
  }

  Widget _tab(
      WidgetRef ref,
      HomeTab selected,
      HomeTab tab,
      String title,
      IconData icon,
      ) {

    final active = selected == tab;

    return GestureDetector(

      onTap: () {
        ref.read(homeTabProvider.notifier).state = tab;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(right: 8, bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5, ),

        decoration: BoxDecoration(
          gradient: active ? const LinearGradient(
            colors: [
              AppColors.softGold,
              AppColors.luxuryGold,
            ],
          ) : null,

          color: active ? null : Colors.white,

          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(0, 4),
              color: Colors.black.withOpacity(.05),
            ),
          ],
        ),

        child: Row(
          children: [
            Icon(icon, size: 20, color: active ? Colors.white : Colors.black,),
            const SizedBox(width: 8),
            Text(title,
              style: TextStyle(
                color: active ? Colors.white : Colors.black, fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
