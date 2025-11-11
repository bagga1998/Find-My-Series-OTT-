// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:find_my_series/auth/Prefered%20Service/Preferred%20Genres/preferredGenresController.dart';
import 'package:find_my_series/auth/Question%20&%20Answers/questionsScreen1.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Preferedgeners extends StatefulWidget {
  const Preferedgeners({super.key});

  @override
  State<Preferedgeners> createState() => _PreferedgenersState();
}

class _PreferedgenersState extends State<Preferedgeners> {
  final PreferredGenrescontroller objPreferredGenrescontroller = Get.put(PreferredGenrescontroller());

  @override
  void initState() {
    super.initState();
    objPreferredGenrescontroller.fetchPreferredGenres(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        titleText: 'STEPS 3 OF 5',
        leadingText: 'SKIP',
        leadingOnPressed: () {
          Get.to(QuestionListScreen());
        },
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
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: CustomText(
                text: 'Next',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'DM Sans',
                onTap: () async {
                  await objPreferredGenrescontroller.saveSelectedGenres(context);
                  // Get.to(bottomNavBar());
                  Get.to(QuestionListScreen());
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
              if (objPreferredGenrescontroller.isLoading.value &&
                  objPreferredGenrescontroller.preferredGenresList.isEmpty) {
                // 🔹 Shimmer loading
                return ListView.builder(
                  itemCount: 6,
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
                            Container(
                              margin: const EdgeInsets.all(8),
                              height: height * 0.12,
                              width: height * 0.10,
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            SizedBox(width: width * 0.03),
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

              // 🔹 Main List UI
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.03),
                    CustomText(
                      text: "Preferred Genres",
                      color: const Color(0xFF9B51E0),
                      fontSize: width * 0.075,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'DM Sans',
                    ),
                    SizedBox(height: height * 0.01),
                    CustomText(
                      text:
                          "Choose your categories of movies and shows you like to customize your experience.",
                      color: OTTColors.white,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DM Sans',
                    ),
                    SizedBox(height: height * 0.03),
                    Row(
                      children: [
                        CustomText(
                          text:
                              "SELECTED: ${objPreferredGenrescontroller.selectedGenres.length}",
                          color: Colors.white54,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'DM Sans',
                        ),
                        const Spacer(),
                        CustomText(
                          text:
                              "TOTAL: ${objPreferredGenrescontroller.preferredGenresList.length}",
                          color: Colors.white54,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'DM Sans',
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),

                    // 🔹 Genre Cards
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          objPreferredGenrescontroller.preferredGenresList.length,
                      itemBuilder: (context, index) {
                        final lang =
                            objPreferredGenrescontroller.preferredGenresList[index];
                        final isSelected = objPreferredGenrescontroller
                            .selectedGenres
                            .contains(lang.name);

                        return GestureDetector(
                          onTap: () {
                            objPreferredGenrescontroller.toggleGenres(
                                lang.name ?? "", lang.id ?? 0);
                          },
                          child: Container(
                            margin:
                                EdgeInsets.symmetric(vertical: height * 0.008),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                                        duration:
                                            const Duration(milliseconds: 200),
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
