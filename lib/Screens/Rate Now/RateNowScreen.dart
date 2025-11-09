import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Ratenowscreen extends StatefulWidget {
  const Ratenowscreen({super.key});

  @override
  State<Ratenowscreen> createState() => _RatenowscreenState();
}

class _RatenowscreenState extends State<Ratenowscreen> {
  int selectedStars = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingText: 'BACK TO HOMEPAGE',
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
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),

          /// Main content
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.06,
              vertical: height * 0.08,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.08),

                /// Movie Poster
                Container(
                  width: width * 0.55,
                  height: height * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/md1.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                SizedBox(height: height * 0.05),

                /// Text section
                Text(
                  "How would you rate",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: OTTColors.whiteColor.withOpacity(0.8),
                    fontSize: 16,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Kantara: A Legend – Chapter 1?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: OTTColors.whiteColor,
                    fontSize: 20,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: height * 0.03),

                /// Star rating row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(10, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedStars = index + 1;
                        });
                      },
                      child: Icon(
                        Icons.star,
                        size: width * 0.075,
                        color: index < selectedStars
                            ? Colors.amber
                            : Colors.white24,
                      ),
                    );
                  }),
                ),

                SizedBox(height: height * 0.05),

                /// Rate Now Button (with count)
                GestureDetector(
                  onTap: () {
                    if (selectedStars == 0) {
                      Get.snackbar(
                        "Rating Required",
                        "Please select a rating before submitting.",
                        backgroundColor: Colors.black87,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                      );
                    } else {
                      Get.snackbar(
                        "Thank you!",
                        "You rated $selectedStars stars.",
                        backgroundColor: Colors.black87,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.018,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF6A00FF),
                          Color(0xFF8E2DE2),
                        ],
                      ),
                    ),
                    child: Center(
                      child: CustomText(
                        text:  selectedStars == 0
                            ? "Rate Now"
                            : "Rate Now (${selectedStars.toString()} out of 10)",
                        color: OTTColors.whiteColor,
                          fontSize: 15,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w500,
                          // letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
