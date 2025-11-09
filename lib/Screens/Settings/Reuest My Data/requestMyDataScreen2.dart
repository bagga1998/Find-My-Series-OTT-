import 'dart:ui';
import 'package:find_my_series/Screens/Settings/Settings/settingScreen.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/bottomBar.dart';
import 'package:find_my_series/widgets/button.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Requestmydatascreen2 extends StatefulWidget {
  final List<String> pagePath;
  const Requestmydatascreen2({
    super.key,
    this.pagePath = const [
      'Profile',
      'Settings',
      'Account',
      'Request My Data',
    ],
  });

  @override
  State<Requestmydatascreen2> createState() => _Requestmydatascreen2State();
}

class _Requestmydatascreen2State extends State<Requestmydatascreen2> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingText: 'BACK TO PREVIOUS PAGE',
        leadingIcon: Icons.arrow_back_ios_new_rounded,
        showBackArrow: true,
        leadingOnPressed: Get.back,
        leadingIconSize: 18,
        leadingTextStyle: TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: OTTColors.whiteColor,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF161218), Color(0xFF2B1D34)],
        ),
      ),
      body: Stack(
        children: [
          /// Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

          /// Glassmorphism Overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title Row
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: Get.height * 0.025,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB968F0),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomText(
                        text: 'Delete My Account',
                        color: OTTColors.buttoncolour,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  /// Breadcrumb Path
                  Text(
                    widget.pagePath.join(' > '),
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(color: Colors.white.withOpacity(0.2), thickness: 1),

                  const SizedBox(height: 30),

                  /// Deletion Info Section
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: OTTColors.whiteColor,
                        size: 17,
                      ),
                      SizedBox(width: 8),
                      CustomText(
                        text: "Thank You. Your are almont there...",
                        color: OTTColors.whiteColor,
                        fontFamily: 'DM Sans',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    text:
                        "Protecting your privacy and keeping your data secure is very important to us at Find My Series. We’ve sent a confirmation email to the address linked with your account. Please check your inbox and follow the instructions in the email to complete your data retrieval process.",
                    color: OTTColors.preferredServices,
                    fontFamily: 'DM Sans',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    // height: 1.4,
                  ),

                  const SizedBox(height: 25),
             

                  /// Request Account Deletion Button
                  Center(
                    child: CustomButton(
                      text: 'Back to Settings',
                      onPressed: () {
                        Get.offUntil(
                        MaterialPageRoute(builder: (_) => const bottomNavBar()),
                        (route) => route.isFirst,
                      );
                      },

                      gradient: LinearGradient(
                        colors: [
                          OTTColors.buttoncolour,
                          OTTColors.buttoncolour1,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
