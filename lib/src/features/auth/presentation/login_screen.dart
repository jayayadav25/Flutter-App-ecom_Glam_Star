import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth_controller.dart';
import '../providers/auth_providers.dart' show authInProgressProvider;
import '../widgets/auth_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;

    await ref.read(authControllerProvider.notifier).signIn(email, password);
    final state = ref.read(authControllerProvider);

    if (state.user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('logged_in', true);
      if (mounted) context.go('/home');
    } else if (state.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error!)),
      );
    }
  }

  Future<void> _googleSignIn() async {
    ref.read(authInProgressProvider.notifier).state = true;  // Must be first

    await ref.read(authControllerProvider.notifier).signInWithGoogle();
    final state = ref.read(authControllerProvider);

    ref.read(authInProgressProvider.notifier).state = false; // Must be last

    if (state.user != null && mounted) {
      context.go('/home');
    } else if (state.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error!)),
      );
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
                  const SizedBox(height: 24),
                  const Icon(Icons.shopping_bag, size: 84),
                  const SizedBox(height: 12),
                  Text('Welcome back to Trendora',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 24),

                  AuthTextField(
                    controller: _emailCtrl,
                    label: 'Email',
                    hint: 'Enter your email',
                    prefixIcon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Email required';
                      return null;
                    },
                  ),

                  const SizedBox(height: 12),

                  AuthTextField(
                    controller: _passwordCtrl,
                    label: 'Password',
                    hint: 'Enter your password',
                    prefixIcon: Icons.lock,
                    obscureText: _obscure,
                    suffix: IconButton(
                      icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Password required';
                      return null;
                    },
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.push('/forgot-password'),
                      child: const Text('Forgot password?'),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: authState.loading ? null : _submit,
                      child: authState.loading
                          ? const CircularProgressIndicator(strokeWidth: 2)
                          : const Text('Login'),
                    ),
                  ),

                  SizedBox( width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12), ),
                      onPressed: _googleSignIn,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://developers.google.com/identity/images/g-logo.png',
                            height: 20, width: 20, ),
                          const SizedBox(width: 12),
                          const Flexible(
                            child: Text(
                              'Continue with Google',
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () => context.push('/signup'),
                        child: const Text('Sign up'),
                      ),
                    ],
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



