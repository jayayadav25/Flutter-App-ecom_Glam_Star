import 'package:flutter/material.dart';
import '../../../common/styles/app_input_decoration.dart';

class SecurityStep extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPasswordCtrl;
  const SecurityStep({super.key,
    required this.formKey,
    required this.passwordCtrl,
    required this.confirmPasswordCtrl,
  });

  @override
  State<SecurityStep> createState() => _SecurityStepState();
}
class _SecurityStepState extends State<SecurityStep> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: widget.passwordCtrl,
            obscureText: obscurePassword,
            decoration: AppInputDecoration.auth(
              hintText: 'Password',
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,),
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              if (value.length < 6) {
                return 'Minimum 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: widget.confirmPasswordCtrl,
            obscureText: obscureConfirmPassword,
            decoration: AppInputDecoration.auth(
              hintText: 'Confirm Password',
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                icon: Icon(obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                ),
                onPressed: () {
                  setState(() {
                    obscureConfirmPassword = !obscureConfirmPassword;
                  });
                },
              ),
            ),

            validator: (value) {
              if (value != widget.passwordCtrl.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}