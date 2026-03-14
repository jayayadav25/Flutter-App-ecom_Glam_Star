import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/coupon_model.dart';
import '../widgets/coupon_card.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  late Timer _timer;

  final coupons = [
    CouponModel(
      code: "TRE125FF",
      title: "Extra ₹500 off",
      description: "Extra ₹500 off on ₹4000+",
      discount: 500,
      expiry: const Duration(hours: 9, minutes: 18, seconds: 46),
    ),
    CouponModel(
      code: "TRE584TF",
      title: "Extra 15% off",
      description: "Extra 15% off upto ₹200 on orders above ₹700",
      discount: 200,
      expiry: const Duration(hours: 6, minutes: 40),
    ),
    CouponModel(
      code: "TRE256SS",
      title: "Extra ₹500 off",
      description: "Extra ₹500 off on ₹4000+",
      discount: 500,
      expiry: const Duration(hours: 9, minutes: 18, seconds: 46),
    ),
    CouponModel(
      code: "TRE425RR",
      title: "Extra 15% off",
      description: "Extra 15% off upto ₹200 on orders above ₹700",
      discount: 200,
      expiry: const Duration(hours: 6, minutes: 40),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _format(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "$h:$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apply Coupon"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: coupons.length,
        itemBuilder: (_, i) {
          final c = coupons[i];
          return CouponCard(
            coupon: c,
            timeLeft: _format(c.expiry),
            onApply: () {
              context.pop({
                'code': c.code,
                'discount': c.discount,
              });
            },
          );
        },
      ),
    );
  }
}
