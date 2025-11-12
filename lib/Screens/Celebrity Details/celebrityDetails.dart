import 'dart:ui';

import 'package:find_my_series/Screens/Celebrity%20Details/celebrityDetailsController.dart';
import 'package:find_my_series/Screens/Detail%20Page%20Photos/detailPagePhotosScreen.dart';
import 'package:find_my_series/Screens/Detail%20Page%20Videos/detailPageVideoScreen.dart';
import 'package:find_my_series/Screens/Movie%20details%20screen/movieDetailsScreen.dart';
import 'package:find_my_series/Screens/News/All%20News/newsScreen.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/dropdown.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CelebrityDetails extends StatefulWidget {
  final String? celebrityId;
  const CelebrityDetails({super.key, required this.celebrityId});

  @override
  State<CelebrityDetails> createState() => _CelebrityDetailsState();
}

class _CelebrityDetailsState extends State<CelebrityDetails> {
  final GetCelebrityDetailsController celebrityDetailsController = Get.put(
    GetCelebrityDetailsController(),
  );
  bool isMuted = false;
  bool isPlaying = false;
  String? selectedCategory;
  int _likeCount = 216;
  bool isPlayingMoreVideo = false;
  bool isPlayingVideo = false;
  bool _isLiked = false;
  final List<String> categories = [
    'All',
    'Action',
    'Comedy',
    'Drama',
    'Thriller',
  ];
  final List<Map<String, dynamic>> thrillerMovies = [
    {
      "title": "TEHRAN",
      "subtitle": "Tehran",
      "year": "2025",
      "rating": "UA 16+",
      "duration": "2h 45m",
      "score": "8.7",
      "poster": "assets/thriller.png",
      "bookmarked": false,
    },
  ];

@override
void initState() {
  super.initState();

  if (widget.celebrityId != null) {
    celebrityDetailsController.getCelebrityDetails(
      context,
      widget.celebrityId!,
    );
    print("Celebrity ID:- ${widget.celebrityId}");
  } else {
    print("⚠️ celebrityId is null — skipping API call.");
  }
}


  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isMobile = size.width < 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingText: 'BACK TO PREVIOUS PAGE',
        leadingTextStyle: const TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: OTTColors.whiteColor,
        ),
        leadingIcon: Icons.arrow_back_ios_new_rounded,
        leadingIconSize: 18,
        leadingOnPressed: () => Get.back(),
        leadingIconColor: OTTColors.whiteColor,
        showBackArrow: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF161218), Color(0xFF2B1D34)],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: OTTColors.whiteColor),
          ),
        ],
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

          /// ✅ Glassmorphism Overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return CustomText(
                        text: celebrityDetailsController.name.toString(),
                        fontFamily: 'DM Sans',
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: OTTColors.whiteColor,
                      );
                    }),
                    Obx(() {
                      return CustomText(
                        text:
                            '${celebrityDetailsController.rolCategory}   •   Producer   •   Nusic Department',
                        fontFamily: 'DM Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: OTTColors.preferredServices,
                      );
                    }),
                    const SizedBox(height: 20),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: height * 0.3,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            // Background image
                            Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/movieDetails.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // Dark gradient overlay
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.6),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),

                            // Centered Play/Pause button
                            Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isPlaying = !isPlaying;
                                  });
                                },
                                borderRadius: BorderRadius.circular(40),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isPlaying
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 36,
                                  ),
                                ),
                              ),
                            ),

                            // Likes and Volume
                            Positioned(
                              bottom: 12,
                              left: 12,
                              right: 12,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.redAccent,
                                        size: 22,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        '2.4K Likes',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isMuted = !isMuted;
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        isMuted
                                            ? Icons.volume_off
                                            : Icons.volume_up,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isSmallScreen = constraints.maxWidth < 380;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: isSmallScreen ? 4 : 5,
                              child: Obx(() {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    height: height * 0.22,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey[900],
                                    ),
                                    child:
                                        celebrityDetailsController
                                            .photoUrl
                                            .value
                                            .isNotEmpty
                                        ? Image.network(
                                            celebrityDetailsController
                                                .photoUrl
                                                .value,
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (
                                                  context,
                                                  child,
                                                  loadingProgress,
                                                ) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                          color: OTTColors
                                                              .buttoncolour,
                                                        ),
                                                  );
                                                },
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                                      'assets/shahrukh.png',
                                                      fit: BoxFit.contain,
                                                    ),
                                          )
                                        : Image.asset(
                                            'assets/shahrukh.png',
                                            fit: BoxFit.contain,
                                          ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              flex: 6,
                              child: Obx(() {
                                return CustomText(
                                  text: celebrityDetailsController.bio
                                      .toString(),
                                  fontFamily: 'DM Sans',
                                  fontSize: isSmallScreen ? 14 : 12,
                                  fontWeight: FontWeight.w400,
                                  color: OTTColors.preferredServices,
                                  maxLines: 20,
                                );
                              }),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    /// ✅ Add to Watchlist Button
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFBA66F0), Color(0xFF742DFF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: OTTColors.whiteColor,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const CustomText(
                                text: 'Add to Watchlist',
                                color: Colors.white,
                                fontFamily: 'DM Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                          CustomText(
                            text: 'Added by 11.7K Users',
                            color: Colors.white.withOpacity(0.8),
                            fontFamily: 'DM Sans',
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ✅ New Section: Credits / Images / Trivia / More
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoCard('Credits', '290'),
                        _infoCard('Images', '160'),
                        _infoCard('Trivia', '18'),
                        _infoCard('More', ''),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.025,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CustomText(
                          text: "Filmography",
                          color: OTTColors.buttoncolour,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'DM Sans',
                        ),
                        const Spacer(),
                        CustomText(
                          text: 'See All',
                          fontFamily: 'DM Sans',
                          fontSize: 14,
                          color: OTTColors.buttoncolour,
                          onTap: () {
                            // Get.to(const CastScreen());
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        _typeDropdown(width, height),
                        SizedBox(width: width * 0.03),
                        _genresDropdown(width, height),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _filmography(thrillerMovies, width, height),
                    const SizedBox(height: 20),
                    // Videos Section
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.025,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: 'Videos',
                          color: OTTColors.buttoncolour,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        Spacer(),
                        CustomText(
                          text: 'See All',
                          fontFamily: 'DM Sans',
                          fontSize: 14,
                          color: OTTColors.buttoncolour,
                          onTap: () {
                            Get.to(const DetailPageVideoScreen());
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 20 : 20),
                    _buildMainVideoCard(context, isMobile, isTablet),
                    SizedBox(height: isMobile ? 16 : 20),
                    _buildMoreVideosSection(context, isMobile, isTablet),
                    SizedBox(height: isMobile ? 24 : 32),

                    // Photos Section
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.025,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: 'Photos',
                          color: OTTColors.buttoncolour,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        Spacer(),
                        CustomText(
                          text: 'See All',
                          fontFamily: 'DM Sans',
                          fontSize: 14,
                          color: OTTColors.buttoncolour,
                          onTap: () {
                            Get.to(const DetailsPagePhotosScreen());
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 16 : 20),
                    _buildPhotosGrid(context, isMobile, isTablet),
                    SizedBox(height: isMobile ? 24 : 32),
                    // Photos Section
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.025,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: 'Awards',
                          color: OTTColors.buttoncolour,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        Spacer(),
                        CustomText(
                          text: 'See All',
                          fontFamily: 'DM Sans',
                          fontSize: 14,
                          color: OTTColors.buttoncolour,
                          onTap: () {
                            // Get.to(const DetailsPagePhotosScreen());
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 20 : 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ✅ Wins Card
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: width * 0.45,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.15),
                                  width: 1.2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text: 'Wins',
                                    fontFamily: 'DM Sans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: OTTColors.buttoncolour,
                                  ),
                                  SizedBox(height: 6),
                                  CustomText(
                                    text: '131',
                                    fontFamily: 'DM Sans',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: OTTColors.whiteColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        // ✅ Nominations Card
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              width: width * 0.4,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.15),
                                  width: 1.2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text: 'Nominations',
                                    fontFamily: 'DM Sans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: OTTColors.buttoncolour,
                                  ),
                                  SizedBox(height: 6),
                                  CustomText(
                                    text: '162',
                                    fontFamily: 'DM Sans',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: OTTColors.whiteColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 24 : 32),

                    Divider(
                      thickness: 2,
                      color: OTTColors.preferredServices.withOpacity(0.4),
                    ),
                    SizedBox(height: isMobile ? 24 : 32),

                    // Personal Details Section
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.025,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: 'Personal Details',
                          color: OTTColors.buttoncolour,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 20 : 30),

                    CustomText(
                      text: 'Born: ',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    // SizedBox(height: 5),
                    CustomText(
                      text:
                          "${DateFormat('MMM dd, yyyy').format(DateTime.now())}       New Delhi India",
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                    ),

                    SizedBox(height: 10),
                    CustomText(
                      text: 'Spouse: ',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    // SizedBox(height: 5),
                    CustomText(
                      text: 'Gauri Khan   OCT 25, 1991-Present',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                    ),

                    SizedBox(height: 10),
                    CustomText(
                      text: 'Height: ',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    // SizedBox(height: 5),
                    CustomText(
                      text: "5'8\" (1.74 mm)",
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      maxLines: 3,
                    ),

                    SizedBox(height: 10),
                    CustomText(
                      text: 'Official sites:',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                size.width *
                                0.01, // responsive horizontal padding
                            vertical:
                                size.height *
                                0.008, // responsive vertical padding
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: OTTColors.preferredServices.withOpacity(
                                0.7,
                              ),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/facebook.svg',
                                height: isTablet ? 28 : 20,
                                width: isTablet ? 28 : 20,
                              ),
                              SizedBox(
                                width: size.width * 0.02,
                              ), // responsive spacing
                              CustomText(
                                text: 'Facebook',
                                color: OTTColors.preferredServices,
                                fontFamily: 'DM Sans',
                                fontSize: isTablet
                                    ? 18
                                    : 14, // responsive text size
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                size.width *
                                0.01, // responsive horizontal padding
                            vertical:
                                size.height *
                                0.008, // responsive vertical padding
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: OTTColors.preferredServices.withOpacity(
                                0.7,
                              ),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/instagram.svg',
                                height: isTablet ? 28 : 17,
                                width: isTablet ? 28 : 17,
                              ),
                              SizedBox(
                                width: size.width * 0.02,
                              ), // responsive spacing
                              CustomText(
                                text: 'Instagram',
                                color: OTTColors.preferredServices,
                                fontFamily: 'DM Sans',
                                fontSize: isTablet
                                    ? 18
                                    : 14, // responsive text size
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                size.width *
                                0.01, // responsive horizontal padding
                            vertical:
                                size.height *
                                0.008, // responsive vertical padding
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: OTTColors.preferredServices.withOpacity(
                                0.7,
                              ),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/facebook.svg',
                                height: isTablet ? 28 : 20,
                                width: isTablet ? 28 : 20,
                              ),
                              SizedBox(
                                width: size.width * 0.02,
                              ), // responsive spacing
                              CustomText(
                                text: 'Facebook',
                                color: OTTColors.preferredServices,
                                fontFamily: 'DM Sans',
                                fontSize: isTablet
                                    ? 18
                                    : 14, // responsive text size
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    CustomText(
                      text: 'Also known as: ',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),

                    CustomText(
                      text: 'King Khan, SRK, Shahrukh',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                    ),

                    SizedBox(height: isMobile ? 24 : 32),

                    Divider(
                      thickness: 2,
                      color: OTTColors.preferredServices.withOpacity(0.4),
                    ),
                    SizedBox(height: isMobile ? 24 : 32),

                    // Did You Know Section
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.025,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: 'Did You Know?',
                          color: OTTColors.buttoncolour,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 20 : 30),

                    CustomText(
                      text: 'Trivia',
                      color: OTTColors.whiteColor,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),

                    CustomText(
                      text:
                          "His personal bodyguard's name is Yasmin Khan. When his bodyguard got married, Shahrukh gifted him a flat that is located beside his residence Mannat.",
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                    ),

                    SizedBox(height: isMobile ? 20 : 30),

                    CustomText(
                      text: 'Quotes',
                      color: OTTColors.whiteColor,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),

                    CustomText(
                      text:
                          "Yes, I do have a close circle of friends and I am very fortunate to have them as friends. I feel very close to them I think friends are everything in life after your family. You come across lots of people all the time but you only make very few friends and you have to be true to them otherwise what's the point in life?.",
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                    ),

                    SizedBox(height: isMobile ? 24 : 32),

                    Divider(
                      thickness: 2,
                      color: OTTColors.preferredServices.withOpacity(0.4),
                    ),
                    SizedBox(height: isMobile ? 24 : 32),

                    // Did You Know Section
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.025,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: 'Related News',
                          color: OTTColors.buttoncolour,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                        const Spacer(),
                        CustomText(
                          text: 'See All',
                          fontFamily: 'DM Sans',
                          fontSize: 14,
                          color: OTTColors.buttoncolour,
                          onTap: () {
                            Get.to(const NewsScreen());
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 20 : 30),
                    GestureDetector(
                      onTap: () {
                        Get.to(const NewsScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(7),
                                child: Image.asset(
                                  'assets/shahrukh.png',
                                  height: Get.height * 0.1,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: CustomText(
                                  text:
                                      'Shah Rukh Khan convinced Satish Shah for ‘disgusting’ role in ‘Main Hoo Na’',
                                  fontFamily: 'DM Sans',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  maxLines: 5,
                                  color: OTTColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Equal-sized Glassmorphic Info Card
  Widget _infoCard(String title, String value) {
    return Expanded(
      child: Container(
        height: 70, // ✅ Fixed equal height
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: title,
                      color: OTTColors.buttoncolour,
                      fontSize: 13,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                    ),
                    if (value.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      CustomText(
                        text: value,
                        color: OTTColors.whiteColor,
                        fontSize: 15,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _typeDropdown(double width, double height) {
    return SizedBox(
      width: width * 0.3,
      child: CustomDropdownButton2(
        hint: const Text(
          'Type',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        value: selectedCategory,
        dropdownItems: categories,
        onChanged: (value) {
          setState(() {
            selectedCategory = value;
          });
        },
        buttonHeight: height * 0.065,
        buttonWidth: double.infinity,
        borderRadius: 16,
        buttonDecoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
        selectedItemTextColor: Colors.white,
        selectedItemFontWeight: FontWeight.w600,
        enableSearch: false,
      ),
    );
  }

  Widget _genresDropdown(double width, double height) {
    return SizedBox(
      width: width * 0.35,
      child: CustomDropdownButton2(
        hint: const Text(
          'Genres',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        value: selectedCategory,
        dropdownItems: categories,
        onChanged: (value) {
          setState(() {
            selectedCategory = value;
          });
        },
        buttonHeight: height * 0.065,
        buttonWidth: double.infinity,
        borderRadius: 16,
        buttonDecoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
        selectedItemTextColor: Colors.white,
        selectedItemFontWeight: FontWeight.w600,
        enableSearch: false,
      ),
    );
  }

  Widget _buildMainVideoCard(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(isMobile ? 12 : 12),
          child: Stack(
            children: [
              Container(
                height: isMobile ? 200 : (isTablet ? 280 : 240),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(isMobile ? 8 : 12),
                  border: Border.all(
                    color: const Color.fromARGB(255, 63, 63, 63),
                  ),
                  image: const DecorationImage(
                    image: AssetImage('assets/movieDetails.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Likes and Volume
              Positioned(
                bottom: 12,
                left: 12,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Play/Pause Button
                    InkWell(
                      onTap: () {
                        setState(() {
                          isPlayingVideo = !isPlayingVideo;
                        });
                      },
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: OTTColors.whiteColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isPlayingVideo
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: OTTColors.black1,
                          size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8), // Space between button and text
                    // Trailer Text
                    CustomText(
                      text: 'Trailer 2:54',
                      fontFamily: 'DM Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: OTTColors.whiteColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        CustomText(
          text: 'Most Popular Indian Stars of 2024',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: OTTColors.whiteColor,
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isLiked = !_isLiked;
                  _likeCount = _isLiked ? _likeCount + 1 : _likeCount - 1;
                });
              },
              child: Icon(
                _isLiked ? Icons.favorite : Icons.favorite_border,
                size: 22,
                color: _isLiked ? Colors.red : Colors.white,
              ),
            ),
            SizedBox(width: isMobile ? 6 : 8),
            CustomText(
              text: '$_likeCount Likes',
              fontSize: 15,
              color: OTTColors.preferredServices,
              fontWeight: FontWeight.w500,
              fontFamily: 'DM Sans',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMoreVideosSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    return SizedBox(
      height: isMobile ? 85 : 105,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Container(
                  width: isMobile
                      ? 140
                      : 160, // important for horizontal layout

                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromARGB(255, 61, 60, 60),
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/movieDetails.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Centered Play/Pause button
                Positioned(
                  bottom: 12,
                  left: 12,
                  top: 12,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isPlayingMoreVideo = !isPlayingMoreVideo;
                            });
                          },
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: OTTColors.whiteColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isPlayingMoreVideo
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: OTTColors.black1,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8), // Space between button and text
                      // Trailer Text
                      CustomText(
                        text: 'Trailer 2:54',
                        fontFamily: 'DM Sans',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: OTTColors.preferredServices,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPhotosGrid(BuildContext context, bool isMobile, bool isTablet) {
    final itemWidth = isMobile ? 90.0 : (isTablet ? 105.0 : 125.0);
    final itemHeight = isMobile ? 115.0 : (isTablet ? 115.0 : 135.0);

    return SizedBox(
      height: itemHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 6, // You can change this count based on your image list
        separatorBuilder: (context, index) =>
            SizedBox(width: isMobile ? 8 : 12),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
            child: Container(
              width: itemWidth,
              height: itemHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
                color: Colors.transparent,
                image: const DecorationImage(
                  image: AssetImage('assets/grid3.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // _filmography List

  Widget _filmography(
    List<Map<String, dynamic>> items,
    double width,
    double height,
  ) {
    return SizedBox(
      height: height * 0.42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            margin: EdgeInsets.only(right: index == items.length - 1 ? 0 : 16),
            child: _filmographyCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _filmographyCardDesign(
    Map<String, dynamic> item,
    double width,
    double height,
  ) {
    return Container(
      width: width * 0.43,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Poster
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(MovieDetailsScreen(movieId: "1",));
                },
                child: Container(
                  height: height * 0.23,
                  width: MediaQuery.of(context).size.width / 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(item["poster"] ?? ""),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            // Info with Glassmorphism
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  width: width * 0.9,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["subtitle"] ?? item["title"] ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            item["year"] ?? "",
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '•',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item["rating"] ?? "",
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        text: item["duration"] ?? "",
                        color: OTTColors.bottom,
                        fontSize: 12,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xFFFFD700),
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              CustomText(
                                text: item["score"] ?? "",
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                item["bookmarked"] =
                                    !(item["bookmarked"] ?? false);
                              });
                            },
                            child: Icon(
                              item["bookmarked"] == true
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: item["bookmarked"] == true
                                  ? const Color(0xFFB968F0)
                                  : Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
