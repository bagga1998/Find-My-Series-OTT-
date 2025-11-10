// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:find_my_series/Screens/Profile/Get%20Genres/getAllPrefGenresController.dart';
import 'package:find_my_series/auth/Prefered%20Service/Preferred%20Genres/preferredGenresController.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class GetAllSavedGenresScreen extends StatefulWidget {
  const GetAllSavedGenresScreen({super.key});

  @override
  State<GetAllSavedGenresScreen> createState() =>
      _GetOTTPlatformPrefScreenState();
}

class _GetOTTPlatformPrefScreenState extends State<GetAllSavedGenresScreen> {
  final GetAllSavedGenresController getAllSavedGenresController =
      Get.put(GetAllSavedGenresController());

  final PreferredGenrescontroller getAllpreferredGenres =
      Get.put(PreferredGenrescontroller());

  // Track selected platform names
  final RxList<String> selectedPlatforms = <String>[].obs;

  @override
  void initState() {
    super.initState();
    getAllSavedGenresController.fetchAllSavedGenres(context);
    getAllpreferredGenres.fetchPreferredGenres(context);
  }

  void toggleSelection(String platformName) {
    if (selectedPlatforms.contains(platformName)) {
      selectedPlatforms.remove(platformName);
    } else {
      selectedPlatforms.add(platformName);
    }
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
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                if (getAllSavedGenresController.isLoading.value ||
                    getAllSavedGenresController.isLoading.value) {
                  return ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) => shimmerItem(height, width),
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
                            text: 'Interests',
                            color: OTTColors.buttoncolour,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.02),

                      /// Selected Platforms
                      CustomText(
                        text:
                            'Selected: ${getAllSavedGenresController.savedGenresList.length}',
                        color: OTTColors.buttoncolour,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      SizedBox(height: height * 0.01),

                      if (getAllSavedGenresController.savedGenresList.isEmpty)
                        CustomText(
                          text: 'No Interest found.',
                          color: Colors.white70,
                          fontSize: 16,
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: getAllSavedGenresController.savedGenresList.length,
                          itemBuilder: (context, index) {
                            final platform = getAllSavedGenresController.savedGenresList[index];
                            final name = platform.name ?? "Unknown";
                            // final iconUrl = platform.iconUrl;

                            return Obx(() {
                              final isSelected =
                                  selectedPlatforms.contains(name);
                              return GestureDetector(
                                onTap: () => toggleSelection(name),
                                child: platformItem(
                                  name: name,
                                  // iconUrl: iconUrl,
                                  height: height,
                                  width: width,
                                  isSelected: isSelected,
                                ),
                              );
                            });
                          },
                        ),

                      SizedBox(height: height * 0.03),

                      /// All Platforms
                      CustomText(
                        text:
                            'All Interests: ${getAllpreferredGenres.preferredGenresList.length}',
                        color: OTTColors.buttoncolour,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      SizedBox(height: height * 0.01),

                      if (getAllpreferredGenres.preferredGenresList.isEmpty)
                        CustomText(
                          text: 'No available platforms found.',
                          color: Colors.white70,
                          fontSize: 16,
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: getAllpreferredGenres.preferredGenresList.length,
                          itemBuilder: (context, index) {
                            final platform = getAllpreferredGenres.preferredGenresList[index];
                            final name = platform.name ?? "Unknown";
                            // final iconUrl = platform.iconUrl;

                            return Obx(() {
                              final isSelected =
                                  selectedPlatforms.contains(name);
                              return GestureDetector(
                                onTap: () => toggleSelection(name),
                                child: platformItem(
                                  name: name,
                                  // iconUrl: iconUrl,
                                  height: height,
                                  width: width,
                                  isSelected: isSelected,
                                ),
                              );
                            });
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

  /// Shimmer Loading Item
  Widget shimmerItem(double height, double width) {
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.015),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
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
                  Container(height: 16, width: width * 0.4, color: Colors.white24),
                  SizedBox(height: height * 0.01),
                  Container(height: 14, width: width * 0.3, color: Colors.white24),
                  SizedBox(height: height * 0.01),
                  Container(height: 14, width: width * 0.25, color: Colors.white24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Platform Card Item (Selectable)
  Widget platformItem({
    required String name,
    // required String? iconUrl,
    required double height,
    required double width,
    required bool isSelected,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.008),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.015,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isSelected
                    ? [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)]
                    : [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color:Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                // if (iconUrl != null)
                //   ClipRRect(
                //     borderRadius: BorderRadius.circular(8),
                //     child: Image.network(
                //       iconUrl,
                //       height: height * 0.06,
                //       width: height * 0.06,
                //       fit: BoxFit.contain,
                //       errorBuilder: (_, __, ___) => const Icon(
                //         Icons.tv_rounded,
                //         color: Colors.white38,
                //       ),
                //     ),
                //   ),
                // SizedBox(width: width * 0.04),
                Expanded(
                  child: CustomText(
                    text: name,
                    color: OTTColors.whiteColor,
                    fontSize: 18,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                AnimatedOpacity(
                  opacity: isSelected ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.check,
                    color: OTTColors.buttoncolour,
                    size: width * 0.07,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
