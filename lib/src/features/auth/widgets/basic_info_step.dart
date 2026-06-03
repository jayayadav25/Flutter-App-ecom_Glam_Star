import 'package:flutter/material.dart';
import '../../../common/styles/app_input_decoration.dart';

class BasicInfoStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneCtrl;
  const BasicInfoStep({super.key,
    required this.formKey,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.phoneCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameCtrl,
            decoration: AppInputDecoration.auth(
              hintText: 'Full Name',
              prefixIcon: Icons.person_outline,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),
          TextFormField(
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: AppInputDecoration.auth(
              hintText: 'Email Address',
              prefixIcon: Icons.email_outlined,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter email';
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: phoneCtrl,
            keyboardType: TextInputType.phone,
            decoration: AppInputDecoration.auth(
              hintText: 'Phone Number',
              prefixIcon: Icons.phone_outlined,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter phone';
              }
              if (value.length != 10) {
                return 'Enter valid phone number';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}

