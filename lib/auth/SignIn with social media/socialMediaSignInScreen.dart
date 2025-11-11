import 'package:find_my_series/auth/First%20Welcome/welcomeScreen.dart';
import 'package:find_my_series/auth/Help%20&%20Support/help&support.dart';
import 'package:find_my_series/auth/Login%20with%20email/loginScreen.dart';
import 'package:find_my_series/auth/Singup/Sign%20Up/signupScreen.dart';
import 'package:find_my_series/widgets/bottomBar.dart';
import 'package:find_my_series/widgets/button.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';

class SocialMediaSignInScreen extends StatelessWidget {
  const SocialMediaSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/background.svg',
              width: width,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, right: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back + Music Icons Row
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // space icons apart
                    children: [
                     
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromARGB(137, 100, 99, 99),
                            width: 1.5,
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.to(const Welcomescreen());
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: OTTColors.buttoncolour,
                          ),
                          iconSize: 22,
                          padding: const EdgeInsets.all(8),
                          constraints:
                              const BoxConstraints(),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Get.to(const HelpAndSupport());
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                            height * 0.019,
                          ), 
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color.fromARGB(137, 100, 99, 99),
                              width: 1.5,
                            ),
                          ),
                          child: Image.asset(
                            "assets/help.png",
                            height: height * 0.024,
                            width: height * 0.024,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.03),

                  
                  CustomText(
                    text: "WELCOME TO",
                    color: OTTColors.whiteColor,
                    textAlign: TextAlign.left,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 6),
                    SvgPicture.asset(
                    'assets/logo.svg',
                    height: height * (49.18 / 926), // 926 is a typical screen height
                    width: width * (207.07 / 428),  // 428 is a typical screen width
                    ),


                  SizedBox(height: height * 0.04),

                  // Sign in buttons
                  _buildSocialButton(
                    icon: Icons.email,
                    text: "Sign in with Email",
                    onTap: () {
                      Get.to(const Loginscreen());
                    },
                  ),
                  const SizedBox(height: 14),
                  _buildSocialButton(
                    iconWidget: SvgPicture.asset(
                      "assets/google.svg",
                      height: height * 0.025,
                    ),
                    text: "Sign in with Google",
                    onTap: () {},
                  ),
                  const SizedBox(height: 14),
                  _buildSocialButton(
                    iconWidget: SvgPicture.asset(
                      "assets/facebook.svg",
                      height: height * 0.025,
                    ),
                    text: "Sign in with Facebook",
                    onTap: () {},
                  ),

                  SizedBox(height: height * 0.04),

                  Center(
                    child: const CustomText(
                      text: "OR",
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  SizedBox(height: height * 0.04),

                  // Create Account Button with Gradient
                  CustomButton(
                    gradient: LinearGradient(
                      colors: [OTTColors.buttoncolour, OTTColors.buttoncolour1],
                    ),
                    text: 'Create an Account',
                    onPressed: () {
                      Get.to(const Signupscreen());
                    },
                  ),

                  SizedBox(height: height * 0.04),

                  // Terms and Conditions
                  Center(
                    child: const CustomText(
                      text: "By Signing in, You agree to Find My Series",
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: "Terms & Conditions ",
                        color: OTTColors.buttoncolour,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                      CustomText(
                        text: " and ",
                        color: Colors.white70,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                      CustomText(
                        text: " Privacy Policy",
                        color: OTTColors.buttoncolour,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.052),

                  GestureDetector(
                    onTap: () {
                      Get.to(const bottomNavBar());
                    },
                    child: Center(
                      child: const Text(
                        "Continue Without Login",
                        style: TextStyle(
                          color: OTTColors.buttoncolour,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'DM Sans',
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),
                  // SizedBox(height: height * 0.08),

                  // Footer
                  Center(
                    child: const CustomText(
                      text: "© 2025 – findmyseries.in",
                      color: Colors.white38,
                      fontSize: 16,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    IconData? icon,
    Widget? iconWidget,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: Get.height * 0.075,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24, width: 1),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            // Circular Bordered Container for Icon
            Container(
              height: Get.height * 0.045,
              width: Get.width * 0.09,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(137, 100, 99, 99),
                  width: 1.5,
                ), // only border
              ),
              child: Center(
                child:
                    iconWidget ??
                    Icon(icon, color: Colors.white, size: Get.height * 0.025),
              ),
            ),
            const SizedBox(width: 16),
            Center(
              child: CustomText(
                text: text,
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
