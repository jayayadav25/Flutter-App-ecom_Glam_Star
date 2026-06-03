import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../common/styles/app_button_styles.dart';
import '../../../common/styles/colors.dart';
import '../../../common/styles/text_styles.dart';
import '../providers/auth_controller.dart';
import '../providers/step_provider.dart';
import '../widgets/address_step.dart';
import '../widgets/security_step.dart';
import '../widgets/step_model.dart';
import '../widgets/basic_info_step.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {

  // Form Keys
  final _basicFormKey = GlobalKey<FormState>();
  final _securityFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();

  // Controllers
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _stateCtrl = TextEditingController();
  final _pincodeCtrl = TextEditingController();

  // Steps
  final steps = [
    SignupStepModel(
      title: 'Basic Information',
      icon: Icons.person_outline,
    ),
    SignupStepModel(
      title: 'Security Setup',
      icon: Icons.lock_outline,
    ),
    SignupStepModel(
      title: 'Address Details',
      icon: Icons.location_on_outlined,
    ),
  ];


  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    _stateCtrl.dispose();
    _pincodeCtrl.dispose();
    super.dispose();
  }

  // Build Step
  Widget _buildStepContent(
      int stepIndex) {
    switch (stepIndex) {
      case 0:
        return BasicInfoStep(
          formKey: _basicFormKey,
          nameCtrl: _nameCtrl,
          emailCtrl: _emailCtrl,
          phoneCtrl: _phoneCtrl,
        );
      case 1:
        return SecurityStep(
          formKey: _securityFormKey,
          passwordCtrl: _passwordCtrl,
          confirmPasswordCtrl: _confirmPasswordCtrl,
        );
      case 2:
        return AddressStep(
          formKey: _addressFormKey,
          addressCtrl: _addressCtrl,
          cityCtrl: _cityCtrl,
          stateCtrl: _stateCtrl,
          pincodeCtrl: _pincodeCtrl,
        );
      default:
        return const SizedBox();
    }
  }

 // Validate Step
  bool _validateStep(int stepIndex) {
    switch (stepIndex) {
      case 0:
        return _basicFormKey.currentState!.validate();
      case 1:
        return _securityFormKey.currentState!.validate();
      case 2:
        return _addressFormKey.currentState!.validate();
      default:
        return false;
    }
  }

  // Next Step
  Future<void> _nextStep() async {
    FocusScope.of(context).unfocus();
    final currentStep = ref.read(signupStepProvider);
    final isValid = _validateStep(currentStep);
    if (!isValid) return;
    if (currentStep < steps.length - 1) {
      ref.read(signupStepProvider.notifier).state++;
    } else {
      await _signup();
    }
  }

 // Previous Step
  void _previousStep() {
    final currentStep = ref.read(signupStepProvider);
    if (currentStep > 0) {
      ref.read(signupStepProvider.notifier).state--;
    }
  }


  // Signup
  Future<void> _signup() async {
    await ref.read(authControllerProvider.notifier).signUp(
      _nameCtrl.text.trim(),
      _emailCtrl.text.trim(),
      _passwordCtrl.text.trim(),
    );
    final state = ref.read(authControllerProvider);
    if (!mounted) return;
    if (state.user != null) {
      context.go('/home');
    } else if (state.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
        Text(state.error!),),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(signupStepProvider);
    final authState = ref.watch(authControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20,),
          child: Column(
            children: [
              Center(
                child: Image.asset('assets/logo.png', height: 120,),),
              const SizedBox(height: 10),
              const Text('Create Account',
                style: AppTextStyles.title,
              ),
              const SizedBox(height: 10),

              // Stepper
              Row(
                children: List.generate(steps.length, (index) {
                    final isActive = currentStep >= index;
                    return Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300,),
                        margin: const EdgeInsets.symmetric(horizontal: 4,),
                        height: 6,
                        decoration: BoxDecoration(
                          color: isActive ? AppColors.softGold : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20,),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              Text(
                steps[currentStep].title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryBlack,
                ),
              ),

              const SizedBox(height: 30),
              //Card
              Container(
                padding: const EdgeInsets.all(24,),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30,),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.06,),
                      blurRadius: 25,
                      offset: const Offset(0, 10,),
                    ),
                  ],
                ),

                child: _buildStepContent(currentStep,),),
              const SizedBox(height: 30),

             // Buttons
              Row(
                children: [
                  if (currentStep > 0)
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: OutlinedButton(
                          onPressed: _previousStep,
                          style: AppButtonStyles.outlineButton,
                          child: Text('Back',
                            style: AppTextStyles.blackButtonText,
                          ),
                        ),
                      ),
                    ),
                  if (currentStep > 0)
                    const SizedBox(width: 14),

                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: authState.loading ? null : _nextStep,
                        style: AppButtonStyles.primaryButton,
                        child: authState.loading ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : Text(
                          currentStep == steps.length - 1 ? 'Create Account' : 'Continue',
                          style: AppTextStyles.buttonText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

             // Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?',
                    style: AppTextStyles.description,
                  ),
                  TextButton(
                    onPressed: () {context.pop();},
                    style: AppButtonStyles.goldTextButton,
                    child: const Text('Login',
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