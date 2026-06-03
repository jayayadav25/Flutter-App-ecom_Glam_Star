import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/styles/text_styles.dart';

class CheckoutHeader extends ConsumerWidget {
  const CheckoutHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2),
        Text('Order Summary',
          style: AppTextStyles.heading2),

      ],
    );
  }
}