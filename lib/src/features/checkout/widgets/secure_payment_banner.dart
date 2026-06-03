import 'package:flutter/material.dart';

class SecurePaymentBanner
    extends StatelessWidget {

  const SecurePaymentBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade400,
            Colors.green.shade600,
          ],
        ),

        borderRadius:
        BorderRadius.circular(15),
      ),

      child: const Row(
        children: [

          CircleAvatar(
            backgroundColor:
            Colors.white24,

            child: Icon(
              Icons.lock,
              color: Colors.white,
            ),
          ),

          SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  '100% Secure Payments',

                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                    FontWeight.bold,

                    fontSize: 15,
                  ),
                ),

                SizedBox(height: 4),

                // Text(
                //   'Encrypted & protected transactions',
                //
                //   style: TextStyle(
                //     color: Colors.white70,
                //     fontSize: 12,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}













//
// import 'package:flutter/material.dart';
//
// class SecurePaymentBanner
//     extends StatelessWidget {
//
//   const SecurePaymentBanner({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Container(
//       padding: const EdgeInsets.all(18),
//
//       decoration: BoxDecoration(
//         color: Colors.green.shade50,
//
//         borderRadius:
//         BorderRadius.circular(22),
//       ),
//
//       child: const Row(
//         children: [
//
//           Icon(
//             Icons.security,
//             color: Colors.green,
//           ),
//
//           SizedBox(width: 12),
//
//           Expanded(
//             child: Text(
//               '100% Secure Payments',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }