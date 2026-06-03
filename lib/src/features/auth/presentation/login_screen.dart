import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../common/styles/text_styles.dart';
import '../providers/auth_controller.dart';
import '../providers/auth_providers.dart' show authInProgressProvider;

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
    debugPrint(email);
    debugPrint(password);
    await ref.read(authControllerProvider.notifier).signIn(email, password);
    final state = ref.read(authControllerProvider);

    if (state.user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('logged_in', true);
      if (mounted) context.go('/home');
    } else if (state.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Incorrect credentials")
        //Text(state.error!)
        ),
      );
    }
  }

  Future<void> _googleSignIn() async {
    try {
      ref.read(authInProgressProvider.notifier).state = true;
      await ref.read(authControllerProvider.notifier).signInWithGoogle();
      final user = FirebaseAuth.instance.currentUser;
      ref.read(authInProgressProvider.notifier).state = false;
      print("Current User: $user");
      if (user != null && mounted) {
        context.go('/home');
      }

    } catch (e) {
      print("GOOGLE LOGIN UI ERROR:");
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: size.width * 0.4,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset("assets/logo.png"),
                  ),
                ),
              ),

              // Heading

              const Center(
                child: Text('Welcome Back',
                  style: AppTextStyles.title
                ),
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text('Login to continue your shopping',
                  style: AppTextStyles.description,
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 35),

              // Login Card
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
                    children: [
                      // Email
                      TextFormField(
                        controller: _emailCtrl,
                        decoration: _inputDecoration(
                          hintText: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          final emailRegex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );
                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password
                      TextFormField(
                        controller: _passwordCtrl,
                        obscureText: _obscure,
                        decoration: _inputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            splashRadius: 20,
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,

                              color: const Color(0xFF7A7A7A),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscure = !_obscure;
                              });
                            },
                          ),
                        ),
                        validator: (value) {

                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),

                      // Forgot Password

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => context.push('/forgot-password'),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Color(0xFFD4AF37),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Login Button

                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          onPressed: authState.loading ? null : _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF121212),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: authState.loading
                              ? const CircularProgressIndicator(strokeWidth: 2)
                              : const Text('Login', style: TextStyle(fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),),

                        ),
                      ),

                      const SizedBox(height: 20),
                      // Divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Google Button

                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: OutlinedButton(
                          onPressed: _googleSignIn,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://developers.google.com/identity/images/g-logo.png',
                                height: 22,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Continue with Google',
                                style: TextStyle(
                                  color: Color(0xFF121212),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              // Bottom Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Color(0xFF7A7A7A),
                    ),
                  ),

                  TextButton(
                    onPressed: () => context.push('/signup'),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFFD4AF37),
                        fontWeight: FontWeight.bold,
                      ),
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

  // Input Decoration
  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,

      hintStyle: const TextStyle(
        color: Color(0xFF9E9E9E),
        fontSize: 15,
      ),

      prefixIcon: Icon(
        prefixIcon,
        color: const Color(0xFFD4AF37),
      ),

      suffixIcon: suffixIcon,

      filled: true,
      fillColor: const Color(0xFFF8F7F4),

      contentPadding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 18,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: const BorderSide(
          color: Color(0xFFD4AF37),
          width: 1.6,
        ),
      ),
    );
  }
}