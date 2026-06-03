import 'package:flutter/material.dart';
import 'banner_data.dart';

class PremiumBannerCard extends StatelessWidget {
  final BannerData data;

  const PremiumBannerCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6,),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // IMAGE
            Hero(
              tag: data.image,
              child: Image.asset(
                data.image,
                fit: BoxFit.contain,
                cacheWidth: 1400,
                filterQuality:
                FilterQuality.low,
              ),
            ),
            // PREMIUM OVERLAY
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(.15),
                      Colors.black.withOpacity(.55),
                    ],

                    stops: const [.45, .7, 1,],
                  ),
                ),
              ),
            ),

            // OPTIONAL TEXT
            if (data.text.isNotEmpty)
              Positioned(left: 20, right: 20, bottom: 24,
                child: Text(
                  data.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
