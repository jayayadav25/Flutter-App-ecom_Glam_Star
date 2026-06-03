import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import '../domain/entities/editorial_type.dart';
import 'editorial_image_data.dart';

class EditorialCard extends StatefulWidget {

  final EditorialImageData data;
  final double borderRadius;
  final EditorialType type;

  const EditorialCard({
    super.key,
    required this.data,
    this.borderRadius = 28,
    required this.type,
  });

  @override
  State<EditorialCard> createState() => _EditorialCardState();
}

class _EditorialCardState extends State<EditorialCard> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/products', extra: widget.type,);
      },
      onTapDown: (_) {
        setState(() {
          pressed = true;
        });
      },

      onTapUp: (_) {
        setState(() {
          pressed = false;
        });
      },

      onTapCancel: () {
        setState(() {
          pressed = false;
        });
      },

      child: AnimatedScale(
        scale: pressed ? .96 : 1,
        duration: const Duration(milliseconds: 180),
        child: AspectRatio(
          aspectRatio: 3 / 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: widget.data.image,
                  child: Image.asset(
                    widget.data.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(.6),
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 12,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY: 10,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.1),
                          borderRadius: BorderRadius.circular(18),),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.data.brand != null)
                              Text(widget.data.brand!,
                                style: AppTextStyles.bodyText.copyWith(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            if (widget.data.tag != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(widget.data.tag!,
                                  style: AppTextStyles.caption.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                              ),

                            if (widget.data.offer != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6,),
                                  decoration: BoxDecoration(
                                    color: AppColors.softGold,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(widget.data.offer!,
                                    style: AppTextStyles.caption.copyWith(
                                      fontWeight:
                                      FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}