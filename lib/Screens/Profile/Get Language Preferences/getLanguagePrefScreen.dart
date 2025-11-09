// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:find_my_series/Screens/Profile/Get%20Language%20Preferences/getLanguagePrefController.dart';
import 'package:find_my_series/auth/Prefered%20Service/Preferred%20Languages/PreferredlanguagesController.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class GetLanguagePrefScreen extends StatefulWidget {
  const GetLanguagePrefScreen({super.key});

  @override
  State<GetLanguagePrefScreen> createState() => _GetLanguagePrefScreenState();
}

class _GetLanguagePrefScreenState extends State<GetLanguagePrefScreen> {
  final Getlanguageprefcontroller controller = Get.put(
    Getlanguageprefcontroller(),
  );
  final Preferredlanguagescontroller getAllLanguagesCOntroller = Get.put(
    Preferredlanguagescontroller(),
  );

  @override
  void initState() {
    super.initState();
    controller.getSavedPreferredLanguagesFunction(context);
    getAllLanguagesCOntroller.fetchPreferredLanguages(context);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

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
          /// ✅ Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

          /// ✅ Blur overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            ),
          ),

          /// ✅ Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return ListView.builder(
                    itemCount: 6, // number of shimmer placeholders
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: height * 0.015),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade800,
                          highlightColor: Colors.grey.shade600,
                          child: Row(
                            children: [
                              // Shimmer Image Placeholder
                              Container(
                                margin: EdgeInsets.all(8),
                                height: height * 0.12,
                                width: height * 0.10,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              SizedBox(width: width * 0.03),

                              // Shimmer Text Section
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 16,
                                      width: width * 0.4,
                                      color: Colors.white24,
                                    ),
                                    SizedBox(height: height * 0.01),
                                    Container(
                                      height: 14,
                                      width: width * 0.3,
                                      color: Colors.white24,
                                    ),
                                    SizedBox(height: height * 0.01),
                                    Container(
                                      height: 14,
                                      width: width * 0.25,
                                      color: Colors.white24,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: width * 0.03),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Header
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: Get.height * 0.026,
                            decoration: BoxDecoration(
                              color: const Color(0xFFB968F0),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 10),
                          CustomText(
                            text: 'Language Preference',
                            color: OTTColors.buttoncolour,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.02),

                      /// Count text
                      CustomText(
                        text:
                            'Selected: ${controller.getSavedLanguageList.length}',
                        color: OTTColors.whiteColor,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      SizedBox(height: height * 0.02),

                      /// Language List
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.getSavedLanguageList.length,
                        itemBuilder: (context, index) {
                          final lang = controller.getSavedLanguageList[index];
                          final isSelected = controller.selectedLanguages
                              .contains(lang.name);

                          return GestureDetector(
                            onTap: () {
                              controller.toggleLanguage(lang.name ?? "");
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: height * 0.008,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.04,
                                      vertical: height * 0.02,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white.withOpacity(0.1),
                                          Colors.white.withOpacity(0.05),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.2),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        CustomText(
                                          text: lang.name ?? "Unknown",
                                          color: OTTColors.preferredServices,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        const Spacer(),
                                        AnimatedOpacity(
                                          opacity: isSelected ? 1.0 : 0.0,
                                          duration: const Duration(
                                            milliseconds: 200,
                                          ),
                                          child: Icon(
                                            Icons.check,
                                            color: OTTColors.buttoncolour,
                                            size: width * 0.08,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      CustomText(
                        text:
                            'All Languages: ${getAllLanguagesCOntroller.preferredLanguageList.length.toString()}',
                        color: OTTColors.whiteColor,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: getAllLanguagesCOntroller
                            .preferredLanguageList
                            .length,
                        itemBuilder: (context, index) {
                          final lang = getAllLanguagesCOntroller
                              .preferredLanguageList[index];
                          final isSelected = controller.selectedLanguages
                              .contains(lang.name);
                          // print('selected language:- $isSelected');

                          return Container(
                            margin: EdgeInsets.symmetric(
                              vertical: height * 0.008,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.04,
                                    vertical: height * 0.02,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white.withOpacity(0.1),
                                        Colors.white.withOpacity(0.05),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.2),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      CustomText(
                                        text: lang.name ?? "Unknown",
                                        color: OTTColors.preferredServices,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      const Spacer(),
                                      AnimatedOpacity(
                                        opacity: isSelected ? 1.0 : 0.0,
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: OTTColors.buttoncolour,
                                          size: width * 0.08,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
