import 'package:flutter/material.dart';

class CouponBottomSheet extends StatelessWidget {
  const CouponBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final coupons = [
      {'code': 'TREND100', 'discount': 100},
      {'code': 'FASHION200', 'discount': 200},
      {'code': 'NEWUSER150', 'discount': 150},
    ];

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Apply Coupon",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),

          TextField(
            decoration: InputDecoration(
              hintText: "Enter coupon code",
              suffixIcon: TextButton(
                child: const Text("APPLY"),
                onPressed: () {},
              ),
            ),
          ),

          const SizedBox(height: 16),

          ...coupons.map((c) {
            return Card(
              child: ListTile(
                title: Text(c['code'] as String),
                subtitle: Text("Save ₹${c['discount']} on this order"),
                trailing: TextButton(
                  child: const Text("APPLY"),
                  onPressed: () {
                    Navigator.pop(context, c);
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
