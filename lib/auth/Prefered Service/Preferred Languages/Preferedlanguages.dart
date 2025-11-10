// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:find_my_series/auth/Prefered%20Service/Preferred%20Genres/preferedGeners.dart';
import 'package:find_my_series/auth/Prefered%20Service/Preferred%20Languages/PreferredlanguagesController.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Preferedlanguages extends StatefulWidget {
  const Preferedlanguages({super.key});

  @override
  State<Preferedlanguages> createState() => _PreferedlanguagesState();
}

class _PreferedlanguagesState extends State<Preferedlanguages> {
  final Preferredlanguagescontroller controller = Get.put(
    Preferredlanguagescontroller(),
  );

  @override
  void initState() {
    super.initState();
    controller.fetchPreferredLanguages(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        titleText: 'STEPS 2 OF 3',
        leadingText: 'SKIP',
        centerTitle: true,
        titleGradient: const LinearGradient(
          colors: [Color(0xFF9B51E0), Color(0xFFBB6BD9)],
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: width * 0.045,
          fontWeight: FontWeight.w400,
          fontFamily: 'DM Sans',
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF161218), Color(0xFF2B1D34)],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: CustomText(
                text: 'Next',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'DM Sans',
                onTap: () {
                  final currentContext = context;

                  // Instantly navigate to next screen

                  // Then call the API in background (non-blocking)
                  Future.delayed(const Duration(milliseconds: 300), () {
                    controller.saveSelectedLanguages(currentContext);
                  });
                  Get.to(const Preferedgeners());
                },
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/background.svg',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
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
                    SizedBox(height: height * 0.03),
                    CustomText(
                      text: "Preferred Languages",
                      color: const Color(0xFF9B51E0),
                      fontSize: width * 0.075,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'DM Sans',
                    ),
                    SizedBox(height: height * 0.01),
                    CustomText(
                      text:
                          "Choose your preferred languages to customize your experience.",
                      color: OTTColors.white,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DM Sans',
                    ),
                    SizedBox(height: height * 0.03),

                    // Selected / Total counts
                    Row(
                      children: [
                        CustomText(
                          text:
                              "SELECTED: ${controller.selectedLanguages.length}",
                          color: Colors.white54,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'DM Sans',
                        ),
                        const Spacer(),
                        CustomText(
                          text:
                              "TOTAL: ${controller.preferredLanguageList.length}",
                          color: Colors.white54,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'DM Sans',
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),

                    // 🔹 List of languages from API
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.preferredLanguageList.length,
                      itemBuilder: (context, index) {
                        final lang = controller.preferredLanguageList[index];
                        final isSelected = controller.selectedLanguages
                            .contains(lang.name);
                        // print('selected language:- $isSelected');

                        return GestureDetector(
                          onTap: () {
                            controller.toggleLanguage(lang.name, lang.id);
                            print(
                              'selected language:- ${controller.selectedLanguages}',
                            );
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

                    SizedBox(height: height * 0.04),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
