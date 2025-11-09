import 'dart:ui';

import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingText: 'BACK TO HOMEPAGE',
        leadingTextStyle: TextStyle(fontFamily: 'DM Sans',fontSize: 16,fontWeight: FontWeight.w600,color: OTTColors.whiteColor),
        leadingIcon: Icons.arrow_back_ios_new_rounded,
        leadingIconSize: 18,
        leadingOnPressed: Get.back,
        leadingIconColor: OTTColors.whiteColor,
        showBackArrow: true,
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
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          Column(
          children: [
            Row(
            children: [
              Container(
                width: 4,
                height: Get.height * 0.03,
                decoration: BoxDecoration(
                  color: const Color(0xFFB968F0),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(width: 10),
              CustomText(
                text: 'Notifications',
                color: OTTColors.buttoncolour,
                fontFamily: 'DM Sans',
               fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
              return _glassCard();
            },),
          )
          ],
                  ),
        ],
        
      ),
    );
  }

    Widget _glassCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Container(
                height: Get.height * 0.15,
                width: Get.height * 0.15 * 0.7, // Maintain aspect ratio
                color: Colors.grey.withOpacity(
                  0.3,
                ), // Placeholder if image not found
                child: Image.asset(
                  'assets/movie.png',
                  height: Get.height * 0.15,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.withOpacity(0.3),
                      child: const Icon(Icons.image, color: Colors.white54),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Dilwale',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DM Sans',
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: 'Ranbir Kapoor returns in this action-packed sequel.',
                      color: OTTColors.preferredServices  ,
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: 'WATCH IT ON NETFLIX',
                      color: OTTColors.buttoncolour,
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
