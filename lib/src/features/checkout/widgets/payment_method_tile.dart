import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/payment_method_model.dart';

import '../provider/payment_session_provider.dart';

class PaymentMethodTile
    extends ConsumerWidget {

  final PaymentMethodModel method;
  final Widget? child;

  const PaymentMethodTile({
    super.key,
    required this.method,
    this.child,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {

    final selectedMethod =
    ref.watch(
      selectedPaymentMethodProvider,
    );

    final isSelected =
        selectedMethod == method.id;

    return AnimatedContainer(
      duration:
      const Duration(
        milliseconds: 300,
      ),

      margin:
      const EdgeInsets.only(
        bottom: 12,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(18),

        border: Border.all(
          color:
          isSelected
              ? Colors.black
              : Colors.grey.shade300,

          width: 1.5,
        ),

        boxShadow: [

          if (isSelected)
            BoxShadow(
              color:
              Colors.black.withOpacity(
                0.08,
              ),

              blurRadius: 14,

              offset:
              const Offset(0, 6),
            ),
        ],
      ),

      child: Column(
        children: [

          /// HEADER
          InkWell(
            borderRadius:
            BorderRadius.circular(
              18,
            ),

            onTap: () {

              ref
                  .read(
                selectedPaymentMethodProvider
                    .notifier,
              )
                  .state = method.id;
            },

            child: Padding(
              padding:
              const EdgeInsets.all(
                20,
              ),

              child: Row(
                children: [

                  Icon(
                    method.icon,
                  ),

                  const SizedBox(
                    width: 14,
                  ),

                  Expanded(
                    child: Text(
                      method.title,

                      style:
                      const TextStyle(
                        fontWeight:
                        FontWeight.w600,

                        fontSize: 15,
                      ),
                    ),
                  ),

                  AnimatedSwitcher(
                    duration:
                    const Duration(
                      milliseconds: 250,
                    ),

                    child: isSelected
                        ? const Icon(
                      Icons
                          .check_circle,

                      key:
                      ValueKey(
                        1,
                      ),
                    )
                        : const Icon(
                      Icons
                          .radio_button_unchecked,

                      key:
                      ValueKey(
                        2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// BODY
          AnimatedCrossFade(
            duration:
            const Duration(
              milliseconds: 300,
            ),

            crossFadeState:
            isSelected &&
                child != null
                ? CrossFadeState
                .showSecond
                : CrossFadeState
                .showFirst,

            firstChild:
            const SizedBox(),

            secondChild: Padding(
              padding:
              const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),

              child:
              child ??
                  const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}












// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../core/models/payment_method_model.dart';
//
// class PaymentMethodTile extends ConsumerStatefulWidget {
//   final PaymentMethodModel method;
//   final bool selected;
//   final VoidCallback onTap;
//   final Widget? child;
//
//   const PaymentMethodTile({
//     super.key,
//     required this.method,
//     required this.selected,
//     required this.onTap,
//     this.child,
//   });
//
//   @override
//   ConsumerState<PaymentMethodTile> createState() => _PaymentMethodTileState();
// }
//
// class _PaymentMethodTileState extends ConsumerState<PaymentMethodTile> {
//   bool expanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       margin: const EdgeInsets.only(bottom: 5),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(
//           color: widget.selected
//               ? Colors.black
//               : Colors.grey.shade300,
//           width: 1.5,
//         ),
//
//         boxShadow: [
//           if (widget.selected)
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 14,
//               offset: const Offset(0, 8),
//             ),
//         ],
//       ),
//
//       child: Column(
//         children: [
//           InkWell(
//             borderRadius: BorderRadius.circular(15),
//             onTap: () {
//               setState(() {
//                 expanded = !expanded;
//               });
//               widget.onTap();
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Row(
//                 children: [
//                   Icon(widget.method.icon,),
//                   const SizedBox(width: 14),
//                   Expanded(
//                     child: Text(widget.method.title,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),
//                   if (widget.selected)
//                     const Icon(Icons.check_circle,),
//                 ],
//               ),
//             ),
//           ),
//
//           if (expanded && widget.child != null)
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: widget.child!,
//             ),
//         ],
//       ),
//     );
//   }
// }