import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OrderFailedScreen extends ConsumerWidget {
  const OrderFailedScreen({
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
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 70,
                  color: Colors.red,
                ),
              ),

              const SizedBox(height: 30),
              const Text('Payment Failed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 14),
              const Text('Something went wrong while placing your order.',
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
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text('Try Again',),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}