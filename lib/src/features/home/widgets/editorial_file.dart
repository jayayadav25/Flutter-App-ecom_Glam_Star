import 'package:flutter/material.dart';

class EditorialSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String> images;

  const EditorialSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (_, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  images[index],
                  width: 140,
                  fit: BoxFit.cover,
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemCount: images.length,
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
