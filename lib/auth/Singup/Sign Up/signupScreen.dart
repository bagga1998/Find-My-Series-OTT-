import 'dart:ui';
import 'package:find_my_series/auth/Singup/Sign%20Up/signupController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:find_my_series/auth/Login%20with%20email/loginScreen.dart';
import 'package:find_my_series/widgets/button.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:find_my_series/widgets/textfiled.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  Signupcontroller objSignupcontroller = Get.put(Signupcontroller());

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool? value = false;

  Widget glassTextField({
    required String hint,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withOpacity(0.02),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CustomTextFormField(
            label: hint,
            controller: controller,
            obscureText: obscure,
            backgroundColor: Colors.transparent,
            labelStyle: TextStyle(color: OTTColors.white.withOpacity(0.7)),
            showLabel: false,
            textColor: OTTColors.white,
            borderColor: Colors.grey[850],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 600;

    double fontSize(double size) => isTablet ? size * 1.2 : size;
    double spacing(double space) => isTablet ? space * 1.2 : space;

    return Scaffold(
      backgroundColor: OTTColors.black1,
      body: SafeArea(
        child: Obx(
          () => Stack(
            children: [
              SvgPicture.asset(
                'assets/background.svg',
                width: width,
                fit: BoxFit.cover,
              ),

              // ---------------------- Main Signup UI ----------------------
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: spacing(height * 0.02)),
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
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: OTTColors.buttoncolour,
                          ),
                        ),
                      ),
                      SizedBox(height: spacing(height * 0.03)),
                      CustomText(
                        text: "Create an account",
                        color: const Color(0xFF9B51E0),
                        fontSize: fontSize(32),
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.left,
                        fontFamily: 'DM Sans',
                      ),
                      CustomText(
                        text: "Please enter your details",
                        color: Colors.white70,
                        textAlign: TextAlign.left,
                        fontSize: fontSize(18),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'DM Sans',
                      ),
                      SizedBox(height: spacing(height * 0.03)),

                      // Full Name
                      CustomText(
                        text: "Full Name",
                        color: Colors.white,
                        fontSize: fontSize(17),
                      ),
                      const SizedBox(height: 8),
                      glassTextField(
                        hint: 'Enter your name',
                        controller: objSignupcontroller.fullnameController,
                      ),
                      SizedBox(height: spacing(height * 0.02)),

                      // Email
                      CustomText(
                        text: "Email Address",
                        color: Colors.white,
                        fontSize: fontSize(17),
                      ),
                      const SizedBox(height: 8),
                      glassTextField(
                        hint: 'Enter your email',
                        controller: objSignupcontroller.emailController,
                      ),
                      SizedBox(height: spacing(height * 0.02)),

                      // Age
                      CustomText(
                        text: "Age",
                        color: Colors.white,
                        fontSize: fontSize(17),
                      ),
                      const SizedBox(height: 8),
                      glassTextField(
                        hint: 'Enter your age',
                        controller: objSignupcontroller.ageController,
                        
                      ),
                      SizedBox(height: spacing(height * 0.02)),

                      // Gender
                      CustomText(
                        text: "Gender",
                        color: Colors.white,
                        fontSize: fontSize(17),
                      ),
                      const SizedBox(height: 8),
                      glassTextField(
                        hint: 'Enter your gender',
                        controller: objSignupcontroller.genderController,
                      ),
                      SizedBox(height: spacing(height * 0.02)),

                      // State
                      CustomText(
                        text: "State",
                        color: Colors.white,
                        fontSize: fontSize(17),
                      ),
                      const SizedBox(height: 8),
                      glassTextField(
                        hint: 'Enter your state',
                        controller: objSignupcontroller.stateController,
                      ),
                      SizedBox(height: spacing(height * 0.02)),

                      // Password
                      CustomText(
                        text: "Create Password",
                        color: Colors.white,
                        fontSize: fontSize(18),
                      ),
                      const SizedBox(height: 8),
                      glassTextField(
                        hint: 'Enter your password',
                        controller: objSignupcontroller.passwordController,
                        obscure: _obscurePassword,
                      ),
                      SizedBox(height: spacing(height * 0.02)),

                      // Confirm Password
                      CustomText(
                        text: "Confirm Password",
                        color: Colors.white,
                        fontSize: fontSize(18),
                      ),
                      const SizedBox(height: 8),
                      glassTextField(
                        hint: 'Confirm your password',
                        controller:
                            objSignupcontroller.confirmPasswordController,
                        obscure: _obscureConfirmPassword,
                      ),
                      SizedBox(height: spacing(height * 0.01)),

                      // Show Password Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: value,
                            activeColor: OTTColors.buttoncolour,
                            onChanged: (bool? newValue) {
                              setState(() {
                                value = newValue;
                                _obscurePassword = !newValue!;
                                _obscureConfirmPassword = !newValue;
                              });
                            },
                          ),
                          CustomText(
                            text: "Show Password",
                            color: Colors.white70,
                            fontSize: fontSize(15),
                          ),
                        ],
                      ),

                      // Submit Button
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: CustomButton(
                          gradient: LinearGradient(
                            colors: [
                              OTTColors.buttoncolour,
                              OTTColors.buttoncolour1,
                            ],
                          ),
                          text: 'Get Started',
                          onPressed: () {
                            final messenger = ScaffoldMessenger.of(context);
                            messenger.hideCurrentMaterialBanner();

                            final fields = {
                              "Full name": objSignupcontroller
                                  .fullnameController.text
                                  .trim(),
                              "Email address": objSignupcontroller
                                  .emailController.text
                                  .trim(),
                              "Age": objSignupcontroller.ageController.text
                                  .trim(),
                              "Gender": objSignupcontroller.genderController.text
                                  .trim(),
                              "State": objSignupcontroller.stateController.text
                                  .trim(),
                              "Password": objSignupcontroller
                                  .passwordController.text
                                  .trim(),
                            };

                            void showAutoDismissBanner(String message) {
                              messenger.showMaterialBanner(
                                MaterialBanner(
                                  content: Text(
                                    message,
                                    style:
                                        const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.redAccent,
                                  leading: const Icon(
                                    Icons.error_outline,
                                    color: Colors.white,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => messenger
                                          .hideCurrentMaterialBanner(),
                                      child: const Text(
                                        'DISMISS',
                                        style:
                                            TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              Future.delayed(const Duration(seconds: 3), () {
                                messenger.hideCurrentMaterialBanner();
                              });
                            }

                            // Empty field validation
                            for (var entry in fields.entries) {
                              if (entry.value.isEmpty) {
                                showAutoDismissBanner(
                                    "Please enter your ${entry.key.toLowerCase()}.");
                                return;
                              }
                            }

                            // Email validation
                            final emailPattern =
                                RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                            if (!emailPattern.hasMatch(objSignupcontroller
                                .emailController.text
                                .trim())) {
                              showAutoDismissBanner(
                                  "Please enter a valid email address.");
                              return;
                            }

                            // Password match validation
                            if (objSignupcontroller.passwordController.text
                                    .trim() !=
                                objSignupcontroller
                                    .confirmPasswordController.text
                                    .trim()) {
                              showAutoDismissBanner(
                                  "Password and Confirm Password do not match.");
                              return;
                            }

                            // API Call
                            objSignupcontroller.userRegisteration(context);
                          },
                        ),
                      ),
                      SizedBox(height: spacing(height * 0.02)),

                      // Login redirect
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Already have an account? ",
                            color: OTTColors.whiteColor,
                            fontSize: fontSize(16),
                          ),
                          CustomText(
                            text: "Sign In",
                            color: OTTColors.buttoncolour,
                            fontSize: fontSize(16),
                            onTap: () {
                              Get.to(const Loginscreen());
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Footer
                      Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: "Terms & Conditions",
                                  color: OTTColors.white,
                                  fontSize: fontSize(15),
                                ),
                                const SizedBox(width: 8),
                                CustomText(
                                  text: "•",
                                  color: OTTColors.white,
                                  fontSize: fontSize(16),
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(width: 8),
                                CustomText(
                                  text: "Privacy Policy",
                                  color: OTTColors.white,
                                  fontSize: fontSize(15),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomText(
                              text: "© 2025 - findmyseries.in",
                              color: Colors.white.withOpacity(0.5),
                              fontSize: fontSize(14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ---------------------- Glass Loader Overlay ----------------------
              if (objSignupcontroller.isLoading.value)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.4),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              CircularProgressIndicator(
                                color: Colors.purpleAccent,
                                strokeWidth: 3,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Creating your account...",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
