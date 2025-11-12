import 'package:find_my_series/auth/First%20Welcome/welcomeScreen.dart';
import 'package:find_my_series/auth/SignIn%20with%20social%20media/socialMediaSignInScreen.dart';
import 'package:find_my_series/widgets/bottomBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    final prefs = await SharedPreferences.getInstance();

    // 🔹 Check if onboarding is completed
    final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

    // 🔹 Get saved token
    final token = prefs.getString('token') ?? '';

    // 🔹 Splash delay
    await Future.delayed(const Duration(seconds: 2));

    if (!onboardingCompleted) {
      // First time → show Welcome Screen (full onboarding flow)
      Get.off(() => const Welcomescreen());
    } else if (token.isEmpty) {
      // Onboarding done, but user not logged in → go to login
      Get.off(() => const SocialMediaSignInScreen());
    } else {
      // Already logged in → go to home
      Get.off(() => const bottomNavBar());
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/logo.svg', // Your app logo
                height: height * 0.15,
              ),
              const SizedBox(height: 20),
              const CustomText(
                text: 'Welcome To FMS',
                color: OTTColors.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
