import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/styles/colors.dart';
import '../../features/home/presentation/screen/home_screen.dart';
import '../../features/orders/presentation/order_history_screen.dart';
import '../../features/cart/presentation/cart_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/search/presentation/search_screen.dart';
import 'custom_bottom_nav_items.dart';

class MainLayout extends ConsumerStatefulWidget {
  const MainLayout({super.key});

  @override
  ConsumerState<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends ConsumerState<MainLayout> {
  int _index = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const OrderHistoryScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: Column(
          children: [
           // SearchBar
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10,),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen(),),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [
                      const Icon(
                        Icons.search, color: Colors.grey,),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text('Search luxury fashion...',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.softGold.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12,
                          ),
                        ),
                        child: const Icon(
                          Icons.mic_none_rounded,
                          size: 20,
                          color: AppColors.softGold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

           // Page content
            Expanded(
              child: IndexedStack(index: _index,
                children: _pages,
              ),
            ),
          ],
        ),
      ),

     // Floating Navbar
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10,),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6,),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),

        child: Row(
          children: [
            CustomBottomNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              isSelected: _index == 0,
              onTap: () {
                setState(() {
                  _index = 0;
                });
              },
            ),
            CustomBottomNavItem(
              icon: Icons.history,
              label: 'Orders',
              isSelected: _index == 1,
              onTap: () {
                setState(() {
                  _index = 1;
                });
              },
            ),
            CustomBottomNavItem(
              icon: Icons.shopping_bag_outlined,
              label: 'Cart',
              isSelected: _index == 2,
              onTap: () {
                setState(() {
                  _index = 2;
                });
              },
            ),
            CustomBottomNavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              isSelected: _index == 3,
              onTap: () {
                setState(() {
                  _index = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}