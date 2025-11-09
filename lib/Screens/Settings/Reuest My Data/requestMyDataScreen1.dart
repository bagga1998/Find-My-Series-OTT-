import 'dart:ui';

import 'package:find_my_series/Screens/Settings/Reuest%20My%20Data/requestMyDataScreen2.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/button.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RequestMydataScreen extends StatelessWidget {
  // const AccountInfo({super.key});
  final List<String> pagePath; // 👈 Add this
  const RequestMydataScreen({
    super.key,
    this.pagePath = const ['Profile', 'Settings', 'Account', 'Request My Data'],
  });

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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                    pagePath.join(' > '),
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

                   
                  CustomText(
                    text:
                        "Don't forget you can access a lot of your data instantly, as well as update your personal information, from your Account settings.",
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
                      text: 'Submit Request',
                      onPressed: () {
                        Get.to(const Requestmydatascreen2());
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
                  Spacer(),
                  // First Line with Contact us
                  Row(
                    children: [
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: OTTColors.preferredServices,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    'If you have a more specific request or for further support, Please ',
                              ),
                              TextSpan(
                                text: 'Contact us.',
                                style: TextStyle(
                                  color: OTTColors.buttoncolour,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Second Line with Learn More
                  Row(
                    children: [
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: OTTColors.preferredServices,
                            ),
                            children: [
                              TextSpan(
                                text: 'Learn More ',
                                style: TextStyle(
                                  color: OTTColors.buttoncolour,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'about how we collect and use data to provide and improve our services.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
