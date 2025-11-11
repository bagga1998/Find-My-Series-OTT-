// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:ui';
import 'package:find_my_series/auth/Prefered%20Service/Preferred%20Languages/Preferedlanguages.dart';
import 'package:find_my_series/auth/Prefered%20Service/Preferred%20Services/preferedServicesController.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Preferedservices1 extends StatefulWidget {
  const Preferedservices1({super.key});

  @override
  State<Preferedservices1> createState() => _Preferedservices1State();
}

class _Preferedservices1State extends State<Preferedservices1> {
  final GetAllpreferredPlatforms objGetAllpreferredPlatforms =
      Get.put(GetAllpreferredPlatforms());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      objGetAllpreferredPlatforms.fetchPreferredPlatforms(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        titleText: 'STEPS 1 OF 5',
        leadingText: 'SKIP',
        leadingOnPressed: () {
          Get.to(Preferedlanguages());
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
            padding: EdgeInsets.only(right: width * 0.04),
            child: Center(
              child: CustomText(
                text: 'Next',
                color: Colors.white,
                fontSize: width * 0.045,
                fontWeight: FontWeight.w600,
                fontFamily: 'DM Sans',
                onTap: () async {
                  await objGetAllpreferredPlatforms
                      .saveSelectedPlatforms(context);
                  Get.to(const Preferedlanguages());
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
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Obx(() {
              if (objGetAllpreferredPlatforms.isLoading.value) {
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

              var platform = objGetAllpreferredPlatforms.preferredPlatformsList;

              if (platform.isEmpty) {
                return Center(
                  child: CustomText(
                    text: "No Platforms Available",
                    color: Colors.white54,
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'DM Sans',
                  ),
                );
              }

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.03),
                    CustomText(
                      text: "Preferred Services",
                      color: const Color(0xFF9B51E0),
                      fontSize: width * 0.075,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'DM Sans',
                    ),
                    SizedBox(height: height * 0.01),
                    CustomText(
                      text:
                          "Choose your favorite streaming platforms to customize your experience.",
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
                              "SELECTED: ${objGetAllpreferredPlatforms.selectedPlatforms.length}",
                          color: Colors.white54,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'DM Sans',
                        ),
                        const Spacer(),
                        CustomText(
                          text: "TOTAL: ${platform.length}",
                          color: Colors.white54,
                          fontSize: width * 0.04,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'DM Sans',
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),

                    /// 🔹 Dynamic Platforms List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: platform.length,
                      itemBuilder: (context, index) {
                        final platformData = platform[index];
                        final platformName = platformData.name ?? 'Unknown';
                        final platformLogo = platformData.iconUrl ?? '';
                        final platformId = platformData.id ?? 0;

                        final isSelected = objGetAllpreferredPlatforms
                            .selectedPlatforms
                            .contains(platformName);

                        return GestureDetector(
                          onTap: () {
                            objGetAllpreferredPlatforms.togglePlatforms(
                              platformName,
                              platformId,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: height * 0.02),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.25),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.025,
                                    vertical: height * 0.013,
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          platformLogo,
                                          width: width * 0.12,
                                          height: width * 0.12,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              width: width * 0.12,
                                              height: width * 0.12,
                                              color: Colors.grey.shade800,
                                              child: const Icon(
                                                Icons.broken_image,
                                                color: Colors.white38,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(width: width * 0.05),
                                      Expanded(
                                        child: Text(
                                          platformName,
                                          style: TextStyle(
                                            color: OTTColors.preferredServices,
                                            fontSize: width * 0.045,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
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
                    SizedBox(height: height * 0.05),
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
