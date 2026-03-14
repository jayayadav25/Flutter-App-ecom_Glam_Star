import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'editorial_image_data.dart';
import 'editorial_image_card.dart';


class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class QuiltedGridSliver extends StatelessWidget {
  final List<EditorialImageData> items;

  const QuiltedGridSliver({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
              (_, index) => EditorialImageCard(
            data: items[index],
            borderRadius: 22,
          ),
          childCount: items.length,
        ),
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          repeatPattern: QuiltedGridRepeatPattern.inverted,
          pattern: [
            QuiltedGridTile(2, 2),
            QuiltedGridTile(2, 1),
            QuiltedGridTile(1, 1),
            //QuiltedGridTile(1, 2),
          ],
        ),
      ),
    );
  }
}

