import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/applied_coupon.dart';
import '../providers/coupon_providers.dart';

class CouponScreen extends ConsumerWidget {
  const CouponScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coupons = [
      {
        'code': 'SAVE100',
        'discount': 100.0,
      },
      {
        'code': 'PREMIUM200',
        'discount': 200.0,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply Coupon'),
      ),
      body: ListView.builder(
        itemCount: coupons.length,
        itemBuilder: (_, index) {
          final coupon = coupons[index];

          return Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              title: Text(coupon['code'].toString()),
              subtitle: Text(
                'Save ₹${coupon['discount']}',
              ),
              trailing: TextButton(
                onPressed: () {
                  ref.read(couponProvider.notifier).applyCoupon(
                    AppliedCouponModel(
                      code: coupon['code'].toString(),
                      discount:
                      coupon['discount'] as double,
                    ),
                  );

                  Navigator.pop(context);
                },
                child: const Text('Apply'),
              ),
            ),
          );
        },
      ),
    );
  }
}
