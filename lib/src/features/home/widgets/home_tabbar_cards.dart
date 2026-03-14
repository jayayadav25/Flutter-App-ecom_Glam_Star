import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/home_provider.dart';

class HomeTabBar extends ConsumerWidget {
  const HomeTabBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(homeTabProvider);

    Widget tabItem({
      required HomeTab tab,
      required String title,
      IconData? icon,
      String? imagePath,
    }) {
      final isActive = selectedTab == tab;

      return GestureDetector(
        onTap: () {
          ref.read(homeTabProvider.notifier).state = tab;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical:0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null)
                    Icon(icon, size: 30, color: Colors.black),

                  if (imagePath != null)
                    CircleAvatar(
                      radius: 15, // 👈 icon-sized
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: AssetImage(imagePath),
                    ),


                  const SizedBox(width: 6),

                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 3,
              width: isActive ? 22 : 0,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 56,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          tabItem(
            tab: HomeTab.home,
            title: "Home",
            icon: Icons.home_outlined,
          ),
          tabItem(
            tab: HomeTab.women,
            title: "Women",
            imagePath: "assets/images/icons/women.png",
          ),
          tabItem(
            tab: HomeTab.men,
            title: "Men",
            imagePath: "assets/images/icons/men.png",
          ),
          tabItem(
            tab: HomeTab.kids,
            title: "Kids",
            imagePath: "assets/images/icons/kids.png",
          ),
        ],
      ),
    );
  }
}
