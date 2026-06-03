import 'package:flutter/material.dart';
import '../../../common/styles/text_styles.dart';
import '../../../core/models/product_model.dart';

class ProductFeaturesSection extends StatelessWidget {
  final ProductModel product;

  const ProductFeaturesSection({
    super.key,
    required this.product,
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
        children: [
          const Text('Highlights',
            style: AppTextStyles.smallTitle
          ),

          const SizedBox(height: 5),

          _item('Color', product.baseColour),
          _item('Season', product.season),
          _item('Usage', product.usage),
          _item('Premium Quality', '100% Authentic'),
          _item('Return Policy', '7 Days Easy Return'),
        ],
      ),
    );
  }

  Widget _item(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, size: 18),
          const SizedBox(width: 10),
          Text(
            '$title : ',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}