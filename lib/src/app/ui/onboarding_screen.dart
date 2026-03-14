import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int index = 0;

  Future<void> complete(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding', true);

    if (context.mounted) context.go('/login');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (i) => setState(() => index = i),
                children: const [
                  _Page(
                    asset: 'assets/onboard_1.jpg',
                    title: 'Discover Premium Fashion',
                    subtitle: 'Curated styles from top designers',
                  ),
                  _Page(
                    asset: 'assets/onboard_2.jpg',
                    title: 'Exclusive Offers',
                    subtitle: 'Personalized deals made for you',
                  ),
                  _Page(
                    asset: 'assets/onboard_3.jpg',
                    title: 'Fast Delivery & Easy Returns',
                    subtitle: 'Shop with complete confidence',
                  ),
                ],
              ),
            ),

            // bottom dots
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  Row(
                    children: List.generate(
                      3,
                          (i) => Container(
                        margin: const EdgeInsets.only(right: 6),
                        width: index == i ? 14 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: index == i ? Colors.black : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),

                  if (index < 2)
                    TextButton(
                      onPressed: () {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text("Next"),
                    )
                  else
                    ElevatedButton(
                      onPressed: () => complete(context),
                      child: const Text("Get Started"),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Page extends StatelessWidget {
  final String asset;
  final String title;
  final String subtitle;

  const _Page({
    Key? key,
    required this.asset,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Image.asset(asset)),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
