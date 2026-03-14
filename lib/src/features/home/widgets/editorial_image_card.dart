import 'package:flutter/material.dart';
import 'editorial_image_data.dart';

class EditorialImageCard extends StatelessWidget {
  final EditorialImageData data;
  final double borderRadius;

  const EditorialImageCard({
    super.key,
    required this.data,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
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
                      Colors.black87,
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

                  // if (data.brand != null)
                  //   Text(
                  //     data.brand!,
                  //     textAlign: TextAlign.center,
                  //     style: const TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 14,
                  //     ),
                  //   ),


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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
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
    );
  }
}
