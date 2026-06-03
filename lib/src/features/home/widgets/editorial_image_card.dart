import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/styles/colors.dart';
import '../domain/entities/editorial_type.dart';
import '../providers/editorial_filter_provider.dart';
import 'editorial_image_data.dart';

class EditorialImageCard extends ConsumerWidget {
  final EditorialImageData data;
  final double borderRadius;
  final EditorialType type;

  const EditorialImageCard({
    super.key,
    required this.data,
    this.borderRadius = 16,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(editorialFilterProvider.notifier,
        ).state = type;
      },
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  data.image,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black38,
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 12,
                right: 12,
                bottom: 14,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (data.tag != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          data.tag!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ),


                    if (data.offer != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5,),
                          decoration: BoxDecoration(
                            color: AppColors.softGold,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            data.offer!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
