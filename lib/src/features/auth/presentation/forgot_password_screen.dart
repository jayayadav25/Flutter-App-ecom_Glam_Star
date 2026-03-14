
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../auth/widgets/auth_text_field.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock_open, size: 80),
                  const SizedBox(height: 12),
                  Text('Reset your password', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 24),

                  AuthTextField(
                    controller: _emailCtrl,
                    label: 'Email',
                    hint: 'Enter your registered email',
                    prefixIcon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Email is required';
                      if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}").hasMatch(value)) return 'Enter a valid email';
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _submit,
                      child: _loading
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('Send reset email'),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back to Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}