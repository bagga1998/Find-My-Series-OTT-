import 'dart:ui';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DetailsPagePhotosScreen extends StatefulWidget {
  const DetailsPagePhotosScreen({super.key});

  @override
  State<DetailsPagePhotosScreen> createState() =>
      _DetailsPagePhotosScreenState();
}

class _DetailsPagePhotosScreenState extends State<DetailsPagePhotosScreen> {
  final List<String> photoList = [
    'assets/grid1.png',
    'assets/grid2.png',
    'assets/grid3.png',
    'assets/grid1.png',
    'assets/grid2.png',
    'assets/grid3.png',
  ];

  void _showFullImage(String imagePath) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            color: Colors.black.withOpacity(0.9),
            child: Center(
              child: InteractiveViewer(
                panEnabled: true,
                minScale: 0.8,
                maxScale: 4.0,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: OTTColors.black1,
      appBar: CustomAppBar(
        leadingText: 'BACK TO PREVIOUS PAGE',
        leadingIcon: Icons.arrow_back_ios_new_rounded,
        showBackArrow: true,
        leadingOnPressed: Get.back,
        leadingIconSize: isTablet ? 22 : 18,
        leadingTextStyle: TextStyle(
          fontFamily: 'DM Sans',
          fontSize: isTablet ? 18 : 16,
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
          /// 🔹 Background
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              width: size.width,
              height: size.height,
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 Optional blur overlay
          BackdropFilter(filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1)),

          /// 🔹 Main content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.015,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔹 Title Row
                  Row(
                    children: [
                      Container(
                        height: isTablet ? 30 : 24,
                        width: 3,
                        color: OTTColors.buttoncolour,
                      ),
                      SizedBox(width: size.width * 0.02),
                      CustomText(
                        text: "Photos (16 Results)",
                        color: OTTColors.buttoncolour,
                        fontSize: isTablet ? 26 : 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'DM Sans',
                      ),
                      const Spacer(),
                      Icon(
                        Icons.filter_list,
                        color: OTTColors.buttoncolour,
                        size: isTablet ? 28 : 22,
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.02),

                  /// 🔹 GridView for Photos
                  Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: photoList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isTablet ? 3 : 2, // 🔹 More columns on tablet
                        mainAxisSpacing: size.height * 0.02,
                        crossAxisSpacing: size.width * 0.04,
                        childAspectRatio: isTablet ? 1.3 : 1, // 🔹 Maintain balance
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _showFullImage(photoList[index]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              photoList[index],
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.contain ,
                            ),
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
