import 'package:flutter/material.dart';
import '../../../common/styles/text_styles.dart';

class ReturnPolicySection extends StatelessWidget {
  const ReturnPolicySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Return & Exchange',
            style: AppTextStyles.smallTitle
          ),

          SizedBox(height: 16),

          _PolicyTile(
            icon: Icons.assignment_return_outlined,
            title: '7 Days Easy Return',
          ),

          _PolicyTile(
            icon: Icons.swap_horiz,
            title: 'Exchange Available',
          ),

          _PolicyTile(
            icon: Icons.verified_user_outlined,
            title: '100% Authentic Product',
          ),
        ],
      ),
    );
  }
}

class _PolicyTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _PolicyTile({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
