import 'package:find_my_series/auth/SignIn%20with%20social%20media/socialMediaSignInScreen.dart';
import 'package:find_my_series/widgets/button.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:find_my_series/widgets/glassMorphismCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Welcomescreen extends StatelessWidget {
  const Welcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: OTTColors.black1,
      body: SafeArea(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/background.svg',
              width: width,
              fit: BoxFit.cover,
            ),
            // The rest of your content
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: height),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.06,
                    vertical: height * 0.06,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      SizedBox(height: height * 0.04),
        
                      const CustomText(
                        text: "Welcome To",
                        color: OTTColors.whiteColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'DM Sans',
                      ),
                       SvgPicture.asset('assets/logo.svg', height: height * 0.08),
        
                      SizedBox(height: height * 0.05),
        
                      GlassCard(
                        iconWidget: Image.asset(
                          'assets/welcomeScreen/build.png',
                          color: Colors.white,
                          height: 2,
                          width: 19,
                        ),
                        title: "BUILD AND MANAGE",
                        subtitle: "Your Watchlist",
                        subtitleStyle: TextStyle(color: OTTColors.yourWatchlist),
                        titleStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          // fontStyle: FontStyle.,
                          fontFamily: 'DM Sans',
                          color: OTTColors.buildandManage,
                          letterSpacing: 1.2,
                        ),
                      ),
        
                      SizedBox(height: height * 0.02),
        
                      GlassCard(
                        iconWidget: Image.asset(
                          'assets/welcomeScreen/build&manage.png',
                          color: Colors.white,
                          height: 28,
                          width: 28,
                        ),
                        title: "RATE AND REVIEW",
                        subtitle: "Your Watchlist",
                        subtitleStyle: TextStyle(color: OTTColors.yourWatchlist),
                        titleStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          // fontStyle: FontStyle.,
                          fontFamily: 'DM Sans',
                          color: OTTColors.buildandManage,
                          letterSpacing: 1.2,
                        ),
                      ),
        
                      SizedBox(height: height * 0.02),
        
                      GlassCard(
                        iconWidget: Image.asset(
                          'assets/welcomeScreen/discover.png',
                          color: Colors.white,
                          height: 28,
                          width: 28,
                        ),
                        title: "DISCOVER CONTENT",
                        subtitle: "From Your Favorite Platforms",
                        subtitleStyle: TextStyle(color: OTTColors.yourWatchlist),
                        titleStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          // fontStyle: FontStyle.,
                          fontFamily: 'DM Sans',
                          color: OTTColors.buildandManage,
                          letterSpacing: 1.2,
                        ),
                      ),
        
                      // SizedBox(height: height * 0.04),
        
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom:16.0),
                        child: CustomText(
                          text:
                              "Sign in to get the most personalized recommendations",
                          color: OTTColors.Signrecommendations,
                          textAlign: TextAlign.center,
                          fontSize: 18,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'DM Sans',
                        ),
                      ),
                      CustomButton(
                        text: "Get Started",
                        
                        gradient: const LinearGradient(
                          colors: [
                            OTTColors.buttoncolour,
                            OTTColors.buttoncolour1,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        // textColor: OTTColors.Signrecommendations,
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DM Sans',
                          color: OTTColors.whiteColor
                        ),
                        width: width,
                        onPressed: () {
                          Get.to(const SocialMediaSignInScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildButton({
  //   required String text,
  //   required Color color,
  //   required Color textColor,
  //   required double width,
  //   required VoidCallback onTap,
  // }) {
  //   return SizedBox(
  //     width: width,
  //     height: 52,
  //     child: ElevatedButton(
  //       onPressed: onTap,
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: color,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10),
  //         ),
  //         elevation: 0,
  //       ),
  //       child: Text(
  //         text,
  //         style: TextStyle(
  //           color: textColor,
  //           fontSize: 16,
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
