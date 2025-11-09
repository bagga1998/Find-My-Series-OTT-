import 'dart:ui';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AllCastCrewScreen extends StatelessWidget {
  const AllCastCrewScreen({super.key});

  final List<Map<String, dynamic>> crewData = const [
    {"title": "Directed By", "count": 1},
    {"title": "Writing Credits", "count": 6},
    {"title": "Cast", "count": 15},
    {"title": "Produced By", "count": 3},
    {"title": "Original Music By", "count": 6},
    {"title": "Cinematography By", "count": 3},
    {"title": "Film Editing By", "count": 5},
    {"title": "Production Design By", "count": 2},
    {"title": "Art Direction By", "count": 3},
    {"title": "Costume Design By", "count": 1},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final double horizontalPadding = isTablet ? 30 : 10;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: OTTColors.black1,
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
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 Background blur pattern (optional glassy look)
          BackdropFilter(filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1)),

          // 🔹 Main content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Title
                  Row(
                    children: [
                      Container(
                        height: 24,
                        width: 3,
                        color: OTTColors.buttoncolour,
                      ),
                      const SizedBox(width: 10),
                      CustomText(
                        text: "All Cast & Crew",
                        color: OTTColors.buttoncolour,
                        fontSize: isTablet ? 28 : 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'DM Sans',
                      ),
                      const Spacer(),
                      Icon(Icons.filter_list, color: OTTColors.buttoncolour),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 🔹 Scrollable list
                  Expanded(
                    child: ListView.separated(
                      itemCount: crewData.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = crewData[index];
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white.withOpacity(0.05),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item["title"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isTablet ? 18 : 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                "${item["count"]}",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: isTablet ? 16 : 12,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.chevron_right,
                                color: Colors.white54,
                                size: 22,
                              ),
                            ],
                          ),
                        );
                      },
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
