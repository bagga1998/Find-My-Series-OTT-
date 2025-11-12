import 'package:find_my_series/auth/First%20Welcome/welcomeScreen.dart';
import 'package:find_my_series/widgets/bottomBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/SignIn with social media/socialMediaSignInScreen.dart';

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

    // Check if welcome screen has been shown
    final seenWelcome = prefs.getBool('welcome_seen') ?? false;

    // Check if user is logged in (example: storing a login flag)
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    await Future.delayed(const Duration(seconds: 2)); // Splash delay

    if (!seenWelcome) {
      // First time → show Welcome Screen
      Get.off(() => const Welcomescreen());
    } else if (isLoggedIn) {
      // Already logged in → go to Home
      Get.off(() => const bottomNavBar());
    } else {
      // Not logged in → go to Social Media Sign-in
      Get.off(() => const SocialMediaSignInScreen());
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
              const CustomText(text: 'Welcom To FMS',color: OTTColors.bottom,)
            ],
          ),
        ),
      ),
    );
  }
}
