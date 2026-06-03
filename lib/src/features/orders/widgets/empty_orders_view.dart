import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../widgets/images.dart';
import '../../../common/styles/text_styles.dart';

class EmptyOrdersView extends ConsumerWidget {
  const EmptyOrdersView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.ordernow,
            width: 325,
            height: 325,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),

          // const Text(
          //   'No Orders Yet',
          //
          //   style: AppTextStyles.heading2,
          // ),

          const SizedBox(height: 10),

           Text(
            "Still Thinking? Your Perfect Choice\n Won't Wait Forever. Order Now!",
             style:AppTextStyles.sectionTitle,
          ),
        ],
      ),
    );
  }
}