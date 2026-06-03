import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../common/styles/app_button_styles.dart';
import '../../auth/providers/auth_controller.dart';
import '../../cart/providers/cart_providers.dart';
import '../../orders/providers/order_history_provider.dart';
import '../../wishlist/provider/wishlist_providers.dart';
import '../providers/profile_providers.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    final userAsync = ref.watch(currentUserProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: userAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (e, _) => Center(child: Text('$e')),
          data: (user) {
            if (user == null) {
              return const Center(
                child: Text("No User"),
              );
            }

            return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ProfileHeader(
                    user: user,
                    onEdit: () {
                      context.push('/edit-profile', extra: user,);
                    },
                  ),

                  const SizedBox(height: 10),
                  ProfileTile(
                    title: 'Wishlist',
                    icon: Icons.favorite,
                    onTap: () {
                      context.push('/wishlist',);
                    },
                  ),

                  const SizedBox(height: 10),
                  ProfileTile(
                    title: 'Saved Addresses',
                    icon: Icons.location_on,
                    onTap: () {
                      context.push('/addresses',);
                    },
                  ),

                  const SizedBox(height: 10),

         // settings
           // const SizedBox(height: 14),
           //  ProfileTile(
           //    title: 'Notifications',
           //    icon: Icons.notifications_none,
           //    trailing: Switch( value: true,
           //      onChanged: (_) {},
           //    ),
           //    onTap: () {},
           //  ),
            // const SizedBox(height: 16),

            // ProfileTile(
            //   title: 'Dark Mode',
            //   icon: Icons.dark_mode_outlined,
            //   trailing: Switch(
            //     value: false,
            //     onChanged: (_) {},
            //   ),
            //   onTap: () => context.push('/theme-switcher'),
            // ),
           // const SizedBox(height: 16),
            ProfileTile(
              title: 'Privacy Policy',
              icon: Icons.privacy_tip_outlined,
              onTap: () {},
            ),
            const SizedBox(height: 10),
            ProfileTile(
              title: 'Terms & Conditions',
              icon: Icons.description_outlined,
              onTap: () {},
            ),
            //const SizedBox(height: 40),
                   const SizedBox(height: 16),
                  // Logout button
             SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () async {
                  // CLEAR WISHLIST
                  await ref.read(wishlistProvider.notifier).clearWishlist();
                  // INVALIDATE PROVIDERS
                  ref.invalidate(wishlistProvider);
                  ref.invalidate(cartProvider);
                  ref.invalidate(userOrdersProvider);
                  await ref.read(authControllerProvider.notifier).signOut();
                  if (context.mounted) {
                    context.go('/login');
                  }
                },
                style: AppButtonStyles.primaryButton,
                icon: const Icon(Icons.logout, color: Colors.white,),
                label: const Text('Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
