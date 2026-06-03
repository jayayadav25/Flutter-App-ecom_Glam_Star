import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/upi_provider.dart';

class UpiPaymentForm
    extends ConsumerStatefulWidget {

  const UpiPaymentForm({
    super.key,
  });

  @override
  ConsumerState<UpiPaymentForm>
  createState() =>
      _UpiPaymentFormState();
}

class _UpiPaymentFormState
    extends ConsumerState<UpiPaymentForm> {

  final TextEditingController
  upiController =
  TextEditingController();

  String? errorText;

  bool validateUpi(String value) {

    final regex = RegExp(
      r'^[a-zA-Z0-9.\-_]{2,}@[a-zA-Z]{3,}$',
    );

    return regex.hasMatch(value);
  }

  @override
  void dispose() {

    upiController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final selectedApp =
    ref.watch(
      selectedUpiProvider,
    );

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        /// UPI FIELD
        TextField(
          controller: upiController,

          keyboardType:
          TextInputType.emailAddress,

          decoration: InputDecoration(
            hintText:
            'example@upi',

            errorText: errorText,

            filled: true,

            fillColor:
            Colors.grey.shade100,

            prefixIcon:
            const Icon(
              Icons.account_balance_wallet,
            ),

            border:
            OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(
                16,
              ),

              borderSide:
              BorderSide.none,
            ),
          ),

          onChanged: (value) {

            setState(() {

              if (value.isEmpty) {

                errorText =
                'UPI ID is required';

              } else if (!validateUpi(
                value,
              )) {

                errorText =
                'Enter valid UPI ID';

              } else {

                errorText = null;
              }
            });
          },
        ),

        const SizedBox(height: 18),

        const Text(
          'Select UPI App',

          style: TextStyle(
            fontWeight:
            FontWeight.bold,

            fontSize: 15,
          ),
        ),

        const SizedBox(height: 14),

        Row(
          children: [

            Expanded(
              child: _upiChip(
                ref: ref,
                title: 'Google Pay',
                selected:
                selectedApp ==
                    'Google Pay',
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: _upiChip(
                ref: ref,
                title: 'PhonePe',
                selected:
                selectedApp ==
                    'PhonePe',
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: _upiChip(
                ref: ref,
                title: 'Paytm',
                selected:
                selectedApp ==
                    'Paytm',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _upiChip({

    required WidgetRef ref,
    required String title,
    required bool selected,
  }) {

    return InkWell(
      borderRadius:
      BorderRadius.circular(18),

      onTap: () {

        ref
            .read(
          selectedUpiProvider
              .notifier,
        )
            .state = title;
      },

      child: AnimatedContainer(
        duration:
        const Duration(
          milliseconds: 250,
        ),

        padding:
        const EdgeInsets.symmetric(
          vertical: 14,
        ),

        decoration: BoxDecoration(

          color:
          selected
              ? Colors.black
              : Colors.grey.shade100,

          borderRadius:
          BorderRadius.circular(
            18,
          ),

          border: Border.all(
            color:
            selected
                ? Colors.black
                : Colors.grey.shade300,
          ),

          boxShadow: [

            if (selected)
              BoxShadow(
                color:
                Colors.black.withOpacity(
                  0.12,
                ),

                blurRadius: 10,
                offset: const Offset(
                  0,
                  4,
                ),
              ),
          ],
        ),

        child: Center(
          child: Text(
            title,

            style: TextStyle(
              color:
              selected
                  ? Colors.white
                  : Colors.black,

              fontWeight:
              FontWeight.w600,

              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}