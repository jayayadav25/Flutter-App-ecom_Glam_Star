import 'package:firebase_mastery_app/src/common/styles/app_button_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CouponSection extends ConsumerStatefulWidget {
  final Function(String) onApply;
  const CouponSection({
    super.key,
    required this.onApply,
  });

  @override
  ConsumerState<CouponSection> createState() => _CouponSectionState();
}

class _CouponSectionState extends ConsumerState<CouponSection> {

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter Coupon Code',
                border: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(
            style: AppButtonStyles.buyNowButton,
            onPressed: () {
              widget.onApply(controller.text.trim(),);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}