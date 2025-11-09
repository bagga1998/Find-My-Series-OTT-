import 'dart:ui';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AboutScreen extends StatelessWidget {
  final List<String> pagePath;
  const AboutScreen({
    super.key,
    this.pagePath = const ['Profile', 'Settings', 'About'],
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
            ),
          ),

          /// Glassmorphism overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                        text: 'About',
                        color: OTTColors.buttoncolour,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  /// Breadcrumb Path
                  CustomText(
                    text: pagePath.join(' > '),
                    color: Colors.grey.shade400,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  const SizedBox(height: 10),

                  Divider(color: Colors.white.withOpacity(0.2), thickness: 1),
                  const SizedBox(height: 20),

                  /// List Items
                  _buildRowItem('App Version', '9.2.2.09'),
                  _divider(),

                  _buildSimpleItem('Get Support'),
                  _divider(),

                  _buildSimpleItem('Write a Review'),
                  _divider(),

                  _buildSimpleItem('Terms and Conditions', highlight: true),
                  _divider(),

                  _buildSimpleItem('Privacy Policy'),
                  _divider(),

                  _buildSimpleItem('3rd Party Licensing Policies'),
                  _divider(),

                  _buildSimpleItem('Your Ads Privacy Choices'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper Widget for items with both title and value (e.g., App Version)
  Widget _buildRowItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            color: OTTColors.whiteColor,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          CustomText(
            text: value,
            color: OTTColors.preferredServices,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ],
      ),
    );
  }

  /// Helper Widget for single clickable items
  Widget _buildSimpleItem(String title, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: CustomText(
        text: title,
        color: highlight ? OTTColors.buttoncolour : OTTColors.whiteColor,
        fontFamily: 'DM Sans',
        fontWeight: highlight ? FontWeight.w500 : FontWeight.w400,
        fontSize: 15,
      ),
    );
  }

  Widget _divider() => Divider(color: Colors.white.withOpacity(0.1), thickness: 1);
}
