import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/home/presentation/screen/home_screen.dart';
import '../../features/orders/presentation/order_history_screen.dart';
import '../../features/cart/presentation/cart_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/search/presentation/search_screen.dart';

class MainLayout extends ConsumerStatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  ConsumerState<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends ConsumerState<MainLayout> {
  int _index = 0;

  List<Widget> get _pages => [
    const HomeScreen(),
    const OrderHistoryScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            // Global Searchbar visible in all tabs
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                child: TextField(
                  readOnly: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SearchScreen(),
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    prefixIcon: const Icon(Icons.search, color: Colors.black54),

                    // Voice Search Icon
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.mic, color: Colors.black87),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Voice input..."),
                          ),
                        );
                      },
                    ),

                    hintText: "Search products...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            // PAGE CONTENT
            Expanded(
              child: IndexedStack(
                index: _index,
                children: _pages,
              ),
            )

          ],
        ),
      ),

      // Bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (i) => setState(() => _index = i),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Order",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
           // icon: BottomCartIcon(isSelected: _index  == 2),
            label: "Cart",
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
