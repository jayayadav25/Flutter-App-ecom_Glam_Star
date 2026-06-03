import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common/styles/app_button_styles.dart';
import '../../../common/styles/app_input_decoration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../../common/styles/text_styles.dart';
import '../../auth/providers/auth_providers.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  static const routeName = '/forgot-password';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    final email = _emailCtrl.text.trim();
    final fb.FirebaseAuth firebaseAuth = ref.read(firebaseAuthProvider);

    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      if (mounted) {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent. Check your inbox.')),
        );
        Navigator.pop(context);
      }
    } on fb.FirebaseAuthException catch (e) {
      setState(() => _loading = false);
      final message = e.message ?? 'Unable to send reset email.';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong. Please try again.')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),

          child: Column(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFF121212),
                      ),
                    ),
                  ),
                  const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF121212),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              const Text(
                'Enter your registered email address.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF7A7A7A),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                     BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF121212),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailCtrl,
                        decoration: AppInputDecoration.auth(
                          hintText: 'Enter your email',
                          prefixIcon: Icons.email_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',);
                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: AppButtonStyles.primaryButton,
                          child: const Text(
                            'Send Reset Link',
                            style: AppTextStyles.buttonText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Remember your password?',
                    style:AppTextStyles.bodyText1
                  ),

                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('Login',
                        style:AppTextStyles.bodyText
                      // style: TextStyle(
                      //   color: Color(0xFFD4AF37),
                      //   fontWeight: FontWeight.bold,
                      // ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}