import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../widgets/images.dart';

class OrderSuccessScreen extends ConsumerWidget {
  const OrderSuccessScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   width: 140,
              //   height: 140,
              //   decoration: BoxDecoration(
              //     color: Colors.green.shade50,
              //     shape: BoxShape.circle,
              //   ),
              //   child: const Icon(
              //     Icons.check,
              //     size: 70,
              //     color: Colors.green,
              //   ),
              // ),

              Image.asset(
                AppImages.order_success,
                width: 325,
                height: 325,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 30),
              const Text('Order Placed Successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),

              const Text('Your luxury order has been confirmed.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 60,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18,),
                    ),
                  ),

                  onPressed: () {context.go('/home',);
                  },
                  child: const Text('Continue Shopping',),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
