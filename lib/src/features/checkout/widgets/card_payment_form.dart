import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardPaymentForm
    extends ConsumerStatefulWidget {

  const CardPaymentForm({
    super.key,
  });

  @override
  ConsumerState<CardPaymentForm>
  createState() =>
      _CardPaymentFormState();
}

class _CardPaymentFormState
    extends ConsumerState<CardPaymentForm> {

  final cardController =
  TextEditingController();

  final expiryController =
  TextEditingController();

  final cvvController =
  TextEditingController();

  final holderController =
  TextEditingController();

  final formKey =
  GlobalKey<FormState>();

  @override
  void dispose() {

    cardController.dispose();

    expiryController.dispose();

    cvvController.dispose();

    holderController.dispose();

    super.dispose();
  }

  String? validateCard(
      String? value,
      ) {

    if (value == null ||
        value.isEmpty) {

      return 'Card number required';
    }

    final cleaned =
    value.replaceAll(' ', '');

    if (cleaned.length != 16) {

      return 'Invalid card number';
    }

    return null;
  }

  String? validateExpiry(
      String? value,
      ) {

    if (value == null ||
        value.isEmpty) {

      return 'Required';
    }

    final regex = RegExp(
      r'^(0[1-9]|1[0-2])\/([0-9]{2})$',
    );

    if (!regex.hasMatch(value)) {

      return 'Invalid expiry';
    }

    return null;
  }

  String? validateCVV(
      String? value,
      ) {

    if (value == null ||
        value.isEmpty) {

      return 'Required';
    }

    if (value.length < 3) {

      return 'Invalid CVV';
    }

    return null;
  }

  String? validateHolder(
      String? value,
      ) {

    if (value == null ||
        value.isEmpty) {

      return 'Card holder required';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: formKey,

      child: Column(
        children: [

          /// CARD NUMBER
          TextFormField(
            controller:
            cardController,

            keyboardType:
            TextInputType.number,

            inputFormatters: [

              FilteringTextInputFormatter
                  .digitsOnly,

              LengthLimitingTextInputFormatter(
                16,
              ),
            ],

            validator:
            validateCard,

            decoration:
            _inputDecoration(
              'Card Number',
              Icons.credit_card,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [

              /// EXPIRY
              Expanded(
                child:
                TextFormField(
                  controller:
                  expiryController,

                  keyboardType:
                  TextInputType.number,

                  inputFormatters: [

                    FilteringTextInputFormatter
                        .allow(
                      RegExp(
                        r'[0-9/]',
                      ),
                    ),

                    LengthLimitingTextInputFormatter(
                      5,
                    ),
                  ],

                  validator:
                  validateExpiry,

                  decoration:
                  _inputDecoration(
                    'MM/YY',
                    Icons.date_range,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// CVV
              Expanded(
                child:
                TextFormField(
                  controller:
                  cvvController,

                  obscureText:
                  true,

                  keyboardType:
                  TextInputType.number,

                  inputFormatters: [

                    FilteringTextInputFormatter
                        .digitsOnly,

                    LengthLimitingTextInputFormatter(
                      3,
                    ),
                  ],

                  validator:
                  validateCVV,

                  decoration:
                  _inputDecoration(
                    'CVV',
                    Icons.lock,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// HOLDER NAME
          TextFormField(
            controller:
            holderController,

            textCapitalization:
            TextCapitalization.words,

            validator:
            validateHolder,

            decoration:
            _inputDecoration(
              'Card Holder Name',
              Icons.person,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(
      String hint,
      IconData icon,
      ) {

    return InputDecoration(
      hintText: hint,

      prefixIcon: Icon(icon),

      filled: true,

      fillColor:
      Colors.grey.shade100,

      contentPadding:
      const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(16),

        borderSide:
        BorderSide.none,
      ),

      errorBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(16),

        borderSide:
        const BorderSide(
          color: Colors.red,
        ),
      ),
    );
  }
}