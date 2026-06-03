import 'package:flutter/material.dart';

class CheckoutBottomBar
    extends StatelessWidget {

  final double total;
  final VoidCallback onTap;

  const CheckoutBottomBar({
    super.key,
    required this.total,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: const BoxDecoration(
        color: Colors.white,

        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14,
          ),
        ],
      ),

      child: SafeArea(
        child: Row(
          children: [

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                mainAxisSize:
                MainAxisSize.min,

                children: [

                  const Text(
                    'Total Amount',
                  ),

                  Text(
                    '₹${total.toStringAsFixed(0)}',

                    style: const TextStyle(
                      fontWeight:
                      FontWeight.bold,

                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: 170,
              height: 56,

              child: ElevatedButton(
                style:
                ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.black,

                  foregroundColor:
                  Colors.white,

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                      18,
                    ),
                  ),
                ),

                onPressed: onTap,

                child: const Text(
                  'Continue',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}