import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_controller.dart';
import '../widgets/auth_text_field.dart';

class SignupScreen extends ConsumerStatefulWidget {
  static const routeName = '/signup';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  bool _obscure1 = true;
  bool _obscure2 = true;
  double _passwordStrength = 0;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  void _checkPasswordStrength(String password) {
    double strength = 0;
    if (password.length >= 6) strength += 0.25;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.25;
    if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.25;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) strength += 0.25;

    setState(() => _passwordStrength = strength);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(authControllerProvider.notifier).signUp(
      _nameCtrl.text.trim(),
      _emailCtrl.text.trim(),
      _passwordCtrl.text.trim(),
    );

    final authState = ref.read(authControllerProvider);

    if (authState.user != null) {
      if (mounted) context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Icon(Icons.person_add, size: 80, color: Colors.black87),
                  const SizedBox(height: 12),
                  Text('Create Your Trendora Account',
                      style: Theme.of(context).textTheme.titleLarge),

                  const SizedBox(height: 32),

                  AuthTextField(
                    controller: _nameCtrl,
                    label: 'Full Name',
                    hint: 'Enter your name',
                    prefixIcon: Icons.person,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Name is required'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  AuthTextField(
                    controller: _emailCtrl,
                    label: 'Email',
                    hint: 'Enter your email',
                    prefixIcon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}")
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  AuthTextField(
                    controller: _passwordCtrl,
                    label: 'Password',
                    hint: 'Create a strong password',
                    prefixIcon: Icons.lock,
                    obscureText: _obscure1,
                    suffix: IconButton(
                      icon: Icon(
                          _obscure1 ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscure1 = !_obscure1),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Minimum 6 characters required';
                      }
                      return null;
                    },
                    // check password strength
                    onChanged: (value) => _checkPasswordStrength(value),
                  ),

                  const SizedBox(height: 8),

                  // Password Strength Indicator
                  LinearProgressIndicator(
                    value: _passwordStrength,
                    backgroundColor: Colors.grey.shade300,
                    minHeight: 6,
                    color: _passwordStrength <= 0.25
                        ? Colors.red
                        : _passwordStrength <= 0.5
                        ? Colors.orange
                        : _passwordStrength <= 0.75
                        ? Colors.lightGreen
                        : Colors.green,
                  ),

                  const SizedBox(height: 16),


                  AuthTextField(
                    controller: _confirmPasswordCtrl,
                    label: 'Confirm Password',
                    hint: 'Re-enter your password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: _obscure2,
                    suffix: IconButton(
                      icon: Icon(
                          _obscure2 ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscure2 = !_obscure2),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm password';
                      }
                      if (value != _passwordCtrl.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: authState.loading ? null : _submit,
                      child: authState.loading
                          ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : const Text('Create Account'),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: const Text('Login'),
                      ),
                    ],
                  ),

                  /// Error message
                  if (authState.error != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      authState.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
