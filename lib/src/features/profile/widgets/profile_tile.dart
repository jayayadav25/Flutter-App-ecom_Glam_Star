import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Widget? trailing;

  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            trailing ??
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
          ],
        ),
      ),
    );
  }
}