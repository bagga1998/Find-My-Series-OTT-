import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';

class DetailPageVideoScreen extends StatefulWidget {
  const DetailPageVideoScreen({super.key});

  @override
  State<DetailPageVideoScreen> createState() => _DetailPageVideoScreenState();
}

class _DetailPageVideoScreenState extends State<DetailPageVideoScreen> {
  final List<Map<String, dynamic>> videos = [
    {
      "title": "Kantara A Legend: Chapter 1",
      "likes": 216,
      "liked": false,
      "playing": false
    },
    {
      "title": "Kantara: Chapter 1 Official Teaser",
      "likes": 216,
      "liked": false,
      "playing": false
    },
    {
      "title": "Kantara A Legend: Teaser Chapter 1",
      "likes": 216,
      "liked": false,
      "playing": false
    },
    {
      "title": "Kantara A Legend: Official Teaser 2",
      "likes": 216,
      "liked": false,
      "playing": false
    },
    {
      "title": "Kantara A Legend: Chapter 1",
      "likes": 216,
      "liked": false,
      "playing": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
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
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              width: size.width,
              height: size.height,
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1)),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.015,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    children: [
                      Container(
                        height: isTablet ? 30 : 24,
                        width: 3,
                        color: OTTColors.buttoncolour,
                      ),
                      SizedBox(width: size.width * 0.02),
                      CustomText(
                        text: "Videos (16 Results)",
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

                  // Video List
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        final video = videos[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: size.height * 0.02),
                          child: Row(
                            children: [
                              // Thumbnail with Play Button
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/movieDetails.png',
                                      width: size.width * 0.40,
                                      height: isTablet
                                          ? size.height * 0.15
                                          : size.height * 0.12,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // Center Play/Pause Button
                                  Container(
                                    width: Get.width * 0.09,
                                    height: Get.width * 0.09,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: Icon(
                                        video['playing']
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        color: Colors.white,
                                        size: isTablet ? 30 : 20,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          // Stop other videos
                                          for (int i = 0;
                                              i < videos.length;
                                              i++) {
                                            videos[i]['playing'] = false;
                                          }
                                          // Toggle current video
                                          video['playing'] = !video['playing'];
                                        });
                                      },
                                    ),
                                  ),
                                  // Duration Label
                                  Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: CustomText(
                                        text: 'Trailer 2:54',
                                        color: Colors.white,
                                        fontSize: isTablet ? 14 : 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Right Side Texts
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03,
                                    vertical: size.height * 0.012,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: video['title'],
                                        color: Colors.white,
                                        fontSize: isTablet ? 18 : 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      SizedBox(height: size.height * 0.005),

                                      // Like Button + Count
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                video['liked'] =
                                                    !video['liked'];
                                                if (video['liked']) {
                                                  video['likes']++;
                                                } else {
                                                  video['likes']--;
                                                }
                                              });
                                            },
                                            child: Icon(
                                              video['liked']
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: video['liked']
                                                  ? Colors.pinkAccent
                                                  : Colors.white70,
                                              size: isTablet ? 22 : 20,
                                            ),
                                          ),
                                          SizedBox(width: size.width * 0.01),
                                          CustomText(
                                            text:
                                                "${video['likes']} Likes",
                                            color: Colors.white70,
                                            fontSize: isTablet ? 14 : 12,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
