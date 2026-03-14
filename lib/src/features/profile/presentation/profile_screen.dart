
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../products/widgets/prduct_debug.dart';
import '../providers/profile_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 70), // space below search bar
      child: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (user) {
          if (user == null) {
            return const Center(child: Text("No user data available"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage:
                      user.profilePic != null ? NetworkImage(user.profilePic!) : null,
                      child: user.profilePic == null
                          ? const Icon(Icons.person, size: 40, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(user.email,
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProductDebugScreen(),
                      ),
                    );
                  },
                  child: const Text("Open Product Debug"),
                ),
                ListTile(
                  leading: const Icon(Icons.admin_panel_settings_outlined),
                  title: const Text('Admin Dashboard'),
                  onTap: () => context.push('/admin'),
                ),
                _menuItem(
                  icon: Icons.edit,
                  label: "Edit Profile",
                  onTap: () => context.push('/edit-profile', extra: user),
                ),

                _menuItem(
                  icon: Icons.shopping_bag,
                  label: "My Orders",
                  onTap: () => context.push('/orders'),
                ),

                _menuItem(
                  icon: Icons.favorite,
                  label: "My Wishlist",
                  onTap: () => context.push('/wishlist'),
                ),

                _menuItem(
                  icon: Icons.color_lens,
                  label: "Change Theme",
                  onTap: () => context.push('/theme-switcher'),
                ),

                _menuItem(
                  icon: Icons.logout,
                  label: "Logout",
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('logged_in');
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) context.go('/login');


                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 26, color: Colors.black87),
            const SizedBox(width: 16),
            Expanded(
              child: Text(label,
                  style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
