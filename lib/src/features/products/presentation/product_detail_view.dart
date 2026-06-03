import 'package:firebase_mastery_app/src/common/styles/text_styles.dart';
import 'package:flutter/material.dart';
import '../../../common/styles/colors.dart';
import '../../../core/models/product_model.dart';
import '../widgets/offer_coupon.dart';
import '../widgets/price_section.dart';
import '../widgets/product_appbar.dart';
import '../widgets/product_feature_section.dart';
import '../widgets/product_image_carousel.dart';
import '../widgets/rating_section.dart';
import '../widgets/return_policy_section.dart';
import '../widgets/size_selector.dart';

class ProductDetailView extends StatelessWidget {
  final ProductModel product;

  const ProductDetailView({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        LuxuryAppBar(product: product),
        SliverToBoxAdapter(
          child: Column(
            children: [
              ProductImageCarousel(product: product),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softGold.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'PREMIUM COLLECTION',
                        style: TextStyle(
                          color: AppColors.softGold,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),
                    Text(product.title,
                      style: AppTextStyles.heading2
                    ),
                    const SizedBox(height: 5),
                    RatingSection(
                      rating: product.averageRating.toDouble(),
                    ),
                    const SizedBox(height: 5),
                    PriceSection(
                      price: product.sellingPrice.toDouble(),
                      mrp: product.actualPrice.toDouble(),
                      discount: product.discount,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.local_shipping_outlined,
                          color: AppColors.emerald,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Free delivery by tomorrow',
                          style: TextStyle(
                            color: AppColors.grey700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),
                    Text(
                      product.inStock
                          ? 'In Stock'
                          : 'Out Of Stock',
                      style: TextStyle(
                        color: product.inStock
                            ? AppColors.success
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizeSelector(),
              const SizedBox(height: 6),
              const OfferCouponSection(),
              const SizedBox(height: 3),
              ProductFeaturesSection(product: product),

              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Product Details',
                      style: AppTextStyles.smallTitle
                    ),

                    const SizedBox(height: 5),

                    Text(
                      product.description,
                      style: AppTextStyles.description
                    ),
                  ],
                ),
              ),
            //  const SizedBox(height: 5),
              const ReturnPolicySection(),

             // const SizedBox(height: 120),
            ],
          ),
        ),
      ],
    );
  }
}