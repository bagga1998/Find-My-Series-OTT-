import 'package:find_my_series/auth/Forgot%20password/forgot%20password%202/resetLinkSent.dart';
import 'package:find_my_series/auth/Help%20&%20Support/help&support.dart';
import 'package:find_my_series/auth/Login%20with%20email/loginScreen.dart';
import 'package:find_my_series/widgets/button.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:find_my_series/widgets/textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
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
              padding: EdgeInsets.symmetric(horizontal: width * 0.05,vertical: height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromARGB(137, 100, 99, 99),
                            width: 1.5,
                          ), // only border
                        ),
                                  
                        child: IconButton(
                          onPressed: () {
                            Get.to(const Loginscreen());
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: OTTColors.buttoncolour,
                          ),
                        ),
                      ),
                      Spacer(),
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
                  const CustomText(
                    text: "Need help signing in?",
                    color: Color(0xFF9B51E0), // purple accent
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.left,
                    fontFamily: 'DM Sans',
                  ),
                  SizedBox(height: height * 0.01),
                  CustomText(
                    text: "Don’t worry, we’ll email you a link to reset your password.",
                    color: Colors.white70,
                    textAlign: TextAlign.left,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'DM Sans',
                  ),
            
                  SizedBox(height: height * 0.03),
                  CustomText(
                    text: "Email Address",
                    color: OTTColors.white,
                    textAlign: TextAlign.left,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'DM Sans',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: CustomTextFormField(
                      label: 'Enter your email',
                      showLabel: false,
                      controller: emailController,
            
                      backgroundColor: Colors.transparent,
                      textColor: OTTColors.whiteColor,
                      labelStyle: TextStyle(color: OTTColors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CustomButton(
                      gradient: LinearGradient(
                        colors: [OTTColors.buttoncolour, OTTColors.buttoncolour1],
                      ),
                      text: 'Send Reset Link',
                      onPressed: () {
                        Get.to(const Resetlinksent());
                      },
                    ),
                  ),
                    Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                              text: "Terms & Conditions",
                              color: OTTColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'DM Sans',
                            ),
                        SizedBox(width: Get.width * 0.02),
                  
                      CustomText(
                        text: '•',
                        color: OTTColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'DM Sans',
                      ),
                        SizedBox(width: Get.width * 0.02),
                      CustomText(
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
                                  color: const Color.fromARGB(179, 144, 142, 142),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'DM Sans',
                                ),
                    ),
                  ),
                
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
