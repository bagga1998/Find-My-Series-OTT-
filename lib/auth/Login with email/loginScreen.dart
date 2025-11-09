import 'dart:ui';

import 'package:find_my_series/auth/Forgot%20password/send%20forgot%20password%20link/forgotPasswordScreen.dart';
import 'package:find_my_series/auth/Help%20&%20Support/help&support.dart';
import 'package:find_my_series/auth/Login%20with%20email/loginController.dart';
import 'package:find_my_series/auth/SignIn%20with%20social%20media/socialMediaSignInScreen.dart';
import 'package:find_my_series/auth/Singup/Sign%20Up/signupScreen.dart';
import 'package:find_my_series/widgets/button.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:find_my_series/widgets/textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final Logincontroller objLogincontroller = Get.put(Logincontroller());
  bool? value = false;
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: OTTColors.black1,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              /// 🔹 Background
              SvgPicture.asset(
                'assets/background.svg',
                width: width,
                fit: BoxFit.cover,
              ),

              /// 🔹 Login form
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.01,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                          137,
                                          100,
                                          99,
                                          99,
                                        ),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Get.to(const SocialMediaSignInScreen());
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        color: OTTColors.buttoncolour,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(const HelpAndSupport());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(height * 0.019),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                            137,
                                            100,
                                            99,
                                            99,
                                          ),
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
                              const CustomText(
                                text: "Login Here!",
                                color: Color(0xFF9B51E0),
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                textAlign: TextAlign.left,
                                fontFamily: 'DM Sans',
                              ),
                              CustomText(
                                text: "Please enter your details",
                                color: Colors.white70,
                                textAlign: TextAlign.left,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'DM Sans',
                              ),
                              SizedBox(height: height * 0.03),
                              CustomText(
                                text: "Email Address",
                                color: Colors.white,
                                textAlign: TextAlign.left,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'DM Sans',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: CustomTextFormField(
                                  label: 'Enter your email',
                                  controller:
                                      objLogincontroller.emailController,
                                  backgroundColor: Colors.transparent,
                                  labelStyle: const TextStyle(
                                    color: OTTColors.white,
                                  ),
                                  textColor: OTTColors.whiteColor,
                                  showLabel: false,
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              CustomText(
                                text: "Password",
                                color: Colors.white,
                                textAlign: TextAlign.left,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'DM Sans',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: CustomTextFormField(
                                  label: 'Enter your password',
                                  controller:
                                      objLogincontroller.passwordController,
                                  backgroundColor: Colors.transparent,
                                  labelStyle: const TextStyle(
                                    color: OTTColors.white,
                                  ),
                                  textColor: OTTColors.whiteColor,
                                  showLabel: false,
                                  obscureText: showPassword,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      showPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.white70,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Row(
                                children: [
                                  Checkbox(
                                    value: value,
                                    activeColor: OTTColors.buttoncolour,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        value = newValue;
                                      });
                                    },
                                  ),
                                  const CustomText(
                                    text: "Remember Me",
                                    color: Colors.white70,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'DM Sans',
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(const ForgotPasswordScreen());
                                    },
                                    child: CustomText(
                                      text: "Forgot Password?",
                                      color: OTTColors.buttoncolour,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'DM Sans',
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: CustomButton(
                                  gradient: LinearGradient(
                                    colors: [
                                      OTTColors.buttoncolour,
                                      OTTColors.buttoncolour1,
                                    ],
                                  ),
                                  text: 'Login',
                                  onPressed: () {
                                    objLogincontroller.loginCOntroller(context);
                                  },
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CustomText(
                                    text: "Don't have an account? ",
                                    color: OTTColors.whiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'DM Sans',
                                  ),
                                  CustomText(
                                    text: "Sign Up",
                                    color: OTTColors.buttoncolour,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'DM Sans',
                                    onTap: () {
                                      Get.to(const Signupscreen());
                                    },
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CustomText(
                                    text: "Terms & Conditions",
                                    color: OTTColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'DM Sans',
                                  ),
                                  SizedBox(width: Get.width * 0.02),
                                  const CustomText(
                                    text: '•',
                                    color: OTTColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'DM Sans',
                                  ),
                                  SizedBox(width: Get.width * 0.02),
                                  const CustomText(
                                    text: "Privacy Policy",
                                    color: OTTColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'DM Sans',
                                  ),
                                ],
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    text: "© 2025 - findmyseries.in",
                                    color: const Color.fromARGB(
                                      179,
                                      144,
                                      142,
                                      142,
                                    ),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'DM Sans',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// 🔹 Modern Glass Loader Overlay
              if (objLogincontroller.isLoading.value)
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
                              CustomText(
                                text: "Please wait...",
                                  color: OTTColors.whiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "DM Sans",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
