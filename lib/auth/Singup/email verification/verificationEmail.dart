import 'package:find_my_series/auth/Help%20&%20Support/help&support.dart';
import 'package:find_my_series/auth/Login%20with%20email/loginScreen.dart';
import 'package:find_my_series/auth/Singup/Sign%20Up/signupScreen.dart';
import 'package:find_my_series/widgets/button.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Verificationemail extends StatelessWidget {
  const Verificationemail({super.key});

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
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Row(
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
                            Get.to(const Signupscreen());
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
                            height * 0.020,
                          ), 
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color.fromARGB(137, 100, 99, 99),
                              width: 1.5,
                            ),
                          ),
                          child: SvgPicture.asset(
                            "assets/welcomeScreen/support.svg",
                            height: height * 0.024,
                            width: height * 0.024,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  ),
                  SizedBox(height: height * 0.03),
                  const CustomText(
                    text: "Verify Your Email",
                    color: Color(0xFF9B51E0), // purple accent
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.left,
                    fontFamily: 'DM Sans',
                  ),
                  SizedBox(height: height * 0.01),
                  CustomText(
                    text: "We’ve sent a verification link.Open your inbox to verify your account.",
                    color: Colors.white70,
                    textAlign: TextAlign.left,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'DM Sans',
                  ),
            
                  SizedBox(height: height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Didn’t receive anything?",
                        color: OTTColors.white,
                        textAlign: TextAlign.left,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'DM Sans',
                      ),
                      CustomText(
                        text: "Resend",
                        color: OTTColors.buttoncolour,
                        textAlign: TextAlign.left,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'DM Sans',
                        onTap: () {
                          // Get.off(ForgotPasswordScreen());
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CustomButton(
                      gradient: LinearGradient(
                        colors: [OTTColors.buttoncolour, OTTColors.buttoncolour1],
                      ),
                      text: 'Go back to Login',
                      textStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'DM Sans',
                        color: OTTColors.whiteColor
                      ),
                      onPressed: () {
                        Get.off(const Loginscreen());
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
