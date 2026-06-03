import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/styles/app_button_styles.dart';
import '../../common/styles/colors.dart';
import '../../common/styles/text_styles.dart';
import 'onboarding_data.dart';
import 'onboarding_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _nextPage() async {
    debugPrint("onboarding button pressed");

    final currentPage = ref.read(onboardingPageProvider);

    if (currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool('onboarding', true);

      if (context.mounted) {
        context.go('/login');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(onboardingPageProvider);
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10,),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();

                    await prefs.setBool('onboarding', true);

                    if (context.mounted) {
                      context.go('/login');
                    }
                  },
                  // onPressed: () {
                  //   context.go('/login');
                  //   },
                  style: AppButtonStyles.goldTextButton,
                  child: const Text('Skip',),
                ),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  ref.read(onboardingPageProvider.notifier).state = index;},
                itemBuilder: (context, index) {
                  final item = onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5,),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 30,
                          child: Hero(
                            tag: item.image,
                            child: Image.asset(item.image,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // TITLE

                        Text(item.title,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.title,),
                        const SizedBox(height: 10),
                        // DESCRIPTION
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.description,
                        ),

                        const Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ),

            // DOT INDICATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                    (index) {
                  final isActive = currentPage == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300,),
                    margin: const EdgeInsets.symmetric(horizontal: 4,),
                    height: 8,
                    width: isActive ? 28 : 8,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.softGold
                          : Colors.grey.shade300,

                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // BUTTON

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: AppButtonStyles.primaryButton,
                  child: Text(
                    currentPage == onboardingData.length - 1
                        ? 'Get Started' : 'Continue',
                    style: AppTextStyles.buttonText,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}