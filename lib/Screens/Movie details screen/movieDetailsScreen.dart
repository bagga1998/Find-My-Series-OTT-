import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:find_my_series/Controller/Add%20to%20watch%20list/addToWatchListController.dart';
import 'package:find_my_series/Screens/All%20Cast%20&%20Crew/allCast&CrewScreen.dart';
import 'package:find_my_series/Screens/Cast/castScreen.dart';
import 'package:find_my_series/Screens/Detail%20Page%20Photos/detailPagePhotosScreen.dart';
import 'package:find_my_series/Screens/Detail%20Page%20Videos/detailPageVideoScreen.dart';
import 'package:find_my_series/Screens/Movie%20details%20screen/videoController.dart';
import 'package:find_my_series/Screens/Rate%20Now/RateNowScreen.dart';
import 'package:find_my_series/Screens/Add%20Users%20Reviews/AddUsersReviewsScreen.dart';
import 'package:find_my_series/Screens/See%20All%20User%20Reviews/SeeAllReviewsScreen.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/button.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  // final Addtowatchlistcontroller objAddtowatchlistcontroller = Get.put(Addtowatchlistcontroller());
  bool isPlaying = false;
  bool isPlayingVideo = false;
  int _likeCount = 216;
  bool isPlayingMoreVideo = false;
  bool isMuted = false;
  bool _isLiked = false;
  bool _isExpanded = false;
  final List<Map<String, dynamic>> popularCelebrities = [
    {
      "title": "Sonam Bajwa",
      "poster": "assets/celebrities.png",
      "bookmarked": false,
    },
    {
      "title": "Janhvi Kapoor",
      "poster": "assets/janvi.png",
      "bookmarked": false,
    },
  ];
  final VideoPlayerControllerX videoController = Get.put(
    VideoPlayerControllerX(),
  );

  @override
  void initState() {
    super.initState();
    videoController.initializeVideo(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    );
  }

  @override
  void dispose() {
    Get.delete<VideoPlayerControllerX>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isMobile = size.width < 600;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: OTTColors.black1,
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
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Kantara: A legend-Chapter1',
                      fontFamily: 'DM Sans',
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: OTTColors.whiteColor,
                    ),
                    CustomText(
                      text: '2025 • UA 16+ • 2h45m',
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: OTTColors.preferredServices,
                    ),
                    SizedBox(height: 20),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Obx(() {
                        if (!videoController.isVideoInitialized.value) {
                          // 🔥 Shimmer placeholder instead of loader
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade800,
                            highlightColor: Colors.grey.shade600,
                            child: Container(
                              height: height * 0.3,
                              width: double.infinity,
                              color: Colors.grey.shade800,
                            ),
                          );
                        }

                        return SizedBox(
                          height: height * 0.3,
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Chewie(
                                controller: videoController.chewieController!,
                              ),

                              // 🎛 Custom Controls Overlay
                              Positioned(
                                bottom: 12,
                                left: 12,
                                right: 12,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // ▶ Play/Pause Button
                                    InkWell(
                                      onTap: videoController.togglePlayPause,
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          videoController.isPlaying.value
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.white,
                                          size: 26,
                                        ),
                                      ),
                                    ),

                                    // 🔇 Mute Button
                                    InkWell(
                                      onTap: videoController.toggleMute,
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          videoController.isMuted.value
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
                        );
                      }),
                    ),

                    SizedBox(height: 20),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isSmallScreen =
                            constraints.maxWidth < 380; // adjust breakpoint

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image takes flexible width
                            Flexible(
                              flex: isSmallScreen ? 4 : 5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/md1.png',
                                  height: height * 0.22,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 12,
                            ), // spacing between image and text
                            // Text takes remaining space and wraps
                            Flexible(
                              flex: 6,
                              child: CustomText(
                                text:
                                    'Exploring the origins of Kaadubettu Shiva during the Kadamba dynasty era, it delves into the untamed wilderness and forgotten lore surrounding his past.',
                                fontFamily: 'DM Sans',
                                fontSize: isSmallScreen ? 14 : 12,
                                fontWeight: FontWeight.w400,
                                color: OTTColors.preferredServices,
                                maxLines: 20,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildGenreChip('Kannada'),
                        _buildGenreChip('Action'),
                        _buildGenreChip('Thriller'),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Netflix Button
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/netflix.png',
                            height: 22,
                          ), // Netflix logo
                          const SizedBox(width: 10),
                          const CustomText(
                            text: 'Watch it on Netflix',
                            color: Colors.white,
                            fontFamily: 'DM Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Inside your widget build method
                    GestureDetector(
                      onTap: () async {
                        final controller = Get.put(AddToWatchlistController());
                        await controller.addToWatchlistFunction(
                          widget.movieId,
                          context,
                        );
                      },
                      child: Container(
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
                                    border: Border.all(color: Colors.white),
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
                    ),
                    const SizedBox(height: 20),

                    // User Reviews Guide Section
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.030,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: "Rating & Reviews",
                          color: OTTColors.buttoncolour,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Container(
                      width: Get.width * 0.9, // responsive width
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              // ⭐ Rating Row
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "8.7",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32,
                                      fontFamily: 'DM Sans',
                                    ),
                                  ),
                                  Text(
                                    "/10",
                                    style: TextStyle(
                                      color: OTTColors.preferredServices,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      fontFamily: 'DM Sans',
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(const Ratenowscreen());
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        // color: Colors.deepPurpleAccent,
                                        gradient: LinearGradient(
                                          colors: [
                                            OTTColors.buttoncolour,
                                            OTTColors.buttoncolour1,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star_border_purple500_rounded,
                                            color: OTTColors.whiteColor,
                                            size: 20,
                                          ),
                                          const CustomText(
                                            text: "Rate Now",
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'DM Sans',
                                            fontSize: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "By 25640 Users",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                              const SizedBox(height: 12),

                              Divider(
                                thickness: 0.5,
                                color: Colors.white.withOpacity(0.2),
                              ),
                              const SizedBox(height: 10),

                              // Review Header
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomText(
                                      text: "Review generated by FMS Smart AI",
                                      color: OTTColors.buttoncolour,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'DM Sans',
                                    ),
                                  ),
                                  const Icon(
                                    Icons.auto_awesome,
                                    color: OTTColors.buttoncolour,
                                    size: 30,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // Review Body
                              const CustomText(
                                text:
                                    "All round of applause to team and specially @Rishab Shetty for carving such story embedded with the divine tale of Panjurli and Samuha Daiva's of Tulunadu. That Daiva will make sure that this movie will stand tall as a majestic one in the history of Indian Cinema's.",
                                color: OTTColors.preferredServices,
                                fontSize: 14,
                                fontFamily: 'DM Sans',
                              ),
                              const SizedBox(height: 20),

                              // Likes, Dislikes, Arrows
                              Row(
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.thumb_up,
                                        color: OTTColors.welcomeContainer,
                                        size: 20,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "253",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.thumb_down,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "15",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white70,
                                        size: 16,
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white70,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Share Button
                    Row(
                      children: [
                        CustomText(
                          text: 'See All Users Review',
                          color: OTTColors.buttoncolour,
                          fontFamily: 'DM Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          onTap: () {
                            Get.to(const UserReviewsScreen());
                          },
                        ),
                        Spacer(),
                        CustomButton(
                          height: Get.height * 0.06,
                          width: Get.width * 0.4,
                          text: 'Share your Review',
                          textStyle: TextStyle(
                            fontSize: 13,
                            color: OTTColors.whiteColor,
                          ),
                          onPressed: () {
                            Get.to(const AddUsersReviewsScreen());
                          },
                          gradient: LinearGradient(
                            colors: [
                              OTTColors.buttoncolour,
                              OTTColors.buttoncolour1,
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.060,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Cast',
                              color: OTTColors.buttoncolour,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                            CustomText(
                              text: 'Top Cast',
                              color: OTTColors.preferredServices,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ],
                        ),
                        Spacer(),
                        CustomText(
                          text: 'See All',
                          fontFamily: 'DM Sans',
                          fontSize: 15,
                          color: OTTColors.buttoncolour,
                          onTap: () {
                            Get.to(const CastScreen());
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    popularCelebritiesListView(
                      popularCelebrities,
                      width,
                      height,
                    ),

                    const SizedBox(height: 20),
                    CustomText(
                      text: 'Director:',
                      fontFamily: 'DM Sans',
                      fontSize: 16,
                      color: OTTColors.whiteColor,
                      fontWeight: FontWeight.w400,
                    ),
                    CustomText(
                      text: 'Rishab Shetty',
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      color: OTTColors.whiteColor,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 15),
                    CustomText(
                      text: 'Writers:',
                      fontFamily: 'DM Sans',
                      fontSize: 16,
                      color: OTTColors.whiteColor,
                      fontWeight: FontWeight.w400,
                    ),
                    CustomText(
                      text: 'Rishab Shetty, Anirudh Mahesh, and others',
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      color: OTTColors.whiteColor,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 20),
                    CustomText(
                      text: 'All Cast & Crew',
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      color: OTTColors.buttoncolour,
                      fontWeight: FontWeight.w400,
                      onTap: () {
                        Get.to(const AllCastCrewScreen());
                      },
                    ),

                    const SizedBox(height: 25),
                    Divider(thickness: 0.5, color: OTTColors.preferredServices),
                    const SizedBox(height: 20),

                    // Videos Section
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.030,
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
                          fontSize: 20,
                        ),
                        Spacer(),
                        CustomText(
                          text: 'See All',
                          fontFamily: 'DM Sans',
                          fontSize: 15,
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
                          height: Get.height * 0.040,
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
                          fontSize: 20,
                        ),
                        Spacer(),
                        CustomText(
                          text: 'See All',
                          fontFamily: 'DM Sans',
                          fontSize: 15,
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

                    // Parents' Guide Section
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.040,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: "Parents' Guide",
                          color: OTTColors.buttoncolour,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        Spacer(),
                        CustomText(
                          text: 'See All',
                          fontFamily: 'DM Sans',
                          fontSize: 15,
                          color: OTTColors.buttoncolour,
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 16 : 20),
                    _buildParentsGuide(context, isMobile),
                    SizedBox(height: 15),
                    Divider(thickness: 0.5, color: OTTColors.preferredServices),
                    SizedBox(height: 15),
                    // Did you know Section Guide
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.040,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: "Did you know",
                          color: OTTColors.buttoncolour,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        Spacer(),
                        CustomText(
                          text: 'See All',
                          fontFamily: 'DM Sans',
                          fontSize: 15,
                          color: OTTColors.buttoncolour,
                        ),
                      ],
                    ),

                    SizedBox(height: isMobile ? 16 : 20),
                    CustomText(
                      text: 'Trivia',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 5),
                    CustomText(
                      text:
                          "Panjurli, the guardian deity with a boar's face, is believed to be an incarnation of Vishnu, blessed by Shiva and Parvati. His fierce visage symbolizes protection and justice, and he is worshipped",
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      // fontWeight: FontWeight.w600,
                    ),

                    SizedBox(height: isMobile ? 17 : 21),
                    CustomText(
                      text: 'Goofs',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 5),
                    CustomText(
                      text:
                          "A modern-day 20-liter water can is visible in the community dining scene during the Brahmakalasha song. It was accidentally left while capturing the shot and could not be edited out later.",
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      // fontWeight: FontWeight.w600,
                    ),

                    SizedBox(height: 15),
                    Divider(thickness: 0.5, color: OTTColors.preferredServices),
                    SizedBox(height: 15),

                    // Details Section Guide
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.040,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: "Details",
                          color: OTTColors.buttoncolour,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 17 : 21),
                    CustomText(
                      text: 'Plot Summary',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 5),
                    CustomText(
                      text:
                          "A modern-day 20-liter water can is visible in the community dining scene during the Brahmakalasha song. It was accidentally left while capturing the shot and could not be edited out later.",
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      // fontWeight: FontWeight.w600,
                    ),

                    SizedBox(height: 10),
                    CustomText(
                      text: 'Genres',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: Get.height * 0.045,
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 4.0,
                              right: 4.0,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white30),
                              ),
                              child: Center(
                                child: CustomText(
                                  text: 'Kannad',
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 15),
                    Divider(thickness: 0.5, color: OTTColors.preferredServices),
                    SizedBox(height: 15),

                    // Details Section Guide
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.040,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: "Details",
                          color: OTTColors.buttoncolour,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomText(
                      text: 'Releasing Date:',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    // SizedBox(height: 5),
                    CustomText(
                      text: DateFormat('MMM dd, yyyy').format(DateTime.now()),
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                    ),

                    SizedBox(height: 10),
                    CustomText(
                      text: 'Country of Origin:',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    // SizedBox(height: 5),
                    CustomText(
                      text: 'India',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                    ),

                    SizedBox(height: 10),
                    CustomText(
                      text: 'Language Spoken:',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    // SizedBox(height: 5),
                    CustomText(
                      text: 'Kannada, Hindi English, Telugu, Tamil, Malayalam',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      maxLines: 3,
                    ),

                    SizedBox(height: 10),
                    CustomText(
                      text: 'Also Known as:',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    // SizedBox(height: 5),
                    CustomText(
                      text: 'kantara A legend: Chapter1(Austria)',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      maxLines: 3,
                    ),

                    SizedBox(height: 10),
                    CustomText(
                      text: 'Production Companies:',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    // SizedBox(height: 5),
                    CustomText(
                      text: 'Hombale Films',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      maxLines: 3,
                    ),

                    SizedBox(height: 15),
                    Divider(thickness: 0.5, color: OTTColors.preferredServices),
                    SizedBox(height: 15),

                    // Box Office Section Guide
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.040,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: "Box Office",
                          color: OTTColors.buttoncolour,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomText(
                      text: 'Opening Weekend US & Canada::',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    // SizedBox(height: 5),
                    CustomText(
                      text: '\$540,000 - Oct 2025',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                    ),

                    SizedBox(height: 10),
                    CustomText(
                      text: 'Gross US & Canada:',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    // SizedBox(height: 5),
                    CustomText(
                      text: '\$540,000',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                    ),

                    SizedBox(height: 10),
                    CustomText(
                      text: 'Gross Worldwide:',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    // SizedBox(height: 5),
                    CustomText(
                      text: '\$2, 446, 973',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      maxLines: 3,
                    ),

                    SizedBox(height: 15),
                    Divider(thickness: 0.5, color: OTTColors.preferredServices),
                    SizedBox(height: 15),

                    // Technical Specs section Guide
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.040,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: "Technical Specs",
                          color: OTTColors.buttoncolour,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        Spacer(),
                        CustomText(
                          text: 'See All',
                          fontFamily: 'DM Sans',
                          fontSize: 15,
                          color: OTTColors.buttoncolour,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    CustomText(
                      text: 'Runtime:',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    // SizedBox(height: 5),
                    CustomText(
                      text: '2h 45m',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                    ),

                    SizedBox(height: 10),
                    CustomText(
                      text: 'Sound Mix:',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    // SizedBox(height: 5),
                    CustomText(
                      text: '12-Track Digital Sound',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                    ),

                    SizedBox(height: 10),
                    CustomText(
                      text: 'Colour:',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    // SizedBox(height: 5),
                    CustomText(
                      text: 'color',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      maxLines: 3,
                    ),

                    SizedBox(height: 10),
                    CustomText(
                      text: 'Aspect Ratio:',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: '2.39:1',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      maxLines: 3,
                    ),

                    SizedBox(height: 15),
                    Divider(thickness: 0.5, color: OTTColors.preferredServices),
                    SizedBox(height: 15),

                    // Related news section Guide
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: Get.height * 0.040,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: "Related News",
                          color: OTTColors.buttoncolour,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        Spacer(),
                        CustomText(
                          text: 'See All',
                          fontFamily: 'DM Sans',
                          fontSize: 15,
                          color: OTTColors.buttoncolour,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: Container(
                          width: width * 0.9,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.01),
                                Colors.white.withOpacity(0.05),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 🖼️ Left image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/md1.png',
                                  height: height * 0.18,
                                  width: height * 0.13,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title
                                    const Text(
                                      'Alia Bhatt Wins National Award',
                                      style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 6),

                                    // Description
                                    Text(
                                      'The actress bags Best Actress for her powerful role in Gangubai Kathiawadi.',
                                      style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                      maxLines: _isExpanded ? null : 2,
                                      overflow: TextOverflow.fade,
                                    ),
                                    const SizedBox(height: 8),

                                    // Read More button
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isExpanded = !_isExpanded;
                                        });
                                      },
                                      child: Text(
                                        _isExpanded ? 'READ LESS' : 'READ MORE',
                                        style: const TextStyle(
                                          color: Color(
                                            0xFF9B5EFF,
                                          ), // Purple shade from image
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.5,
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
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenreChip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white30),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }

  // Popular celebrities

  Widget popularCelebritiesListView(
    List<Map<String, dynamic>> items,
    double width,
    double height,
  ) {
    return SizedBox(
      height: height * 0.33, // 👈 decreased total card height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        // padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            margin: EdgeInsets.only(right: width * 0.04),
            child: _popularCelebritiesCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _popularCelebritiesCardDesign(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Poster (responsive height & fit)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(CastScreen());
                },
                child: Container(
                  height: height * 0.22, // responsive height
                  width:
                      MediaQuery.of(context).size.width /
                      0.5, // take full available width
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(item["poster"] ?? ""),
                      fit: BoxFit
                          .cover, // 👈 keeps image aspect ratio, no stretch
                    ),
                  ),
                ),
              ),
            ),

            // Info section with glass effect
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03,
                    vertical: height * 0.009,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        item["title"] ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.038,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: height * 0.006),

                      // Favourite row
                      // Row(
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           item["isFavorite"] =
                      //               !(item["isFavorite"] ?? false);
                      //         });
                      //       },
                      //       child: Icon(
                      //         item["isFavorite"] == true
                      //             ? Icons.favorite
                      //             : Icons.favorite_border,
                      //         color: item["isFavorite"] == true
                      //             ? Colors.red
                      //             : Colors.white70,
                      //         size: width * 0.060,
                      //       ),
                      //     ),
                      //     const Spacer(),
                      //     CustomText(
                      //       text: 'Add to Favourite',
                      //       fontSize: 13,
                      //       fontFamily: 'DM Sans',
                      //       color: OTTColors.background,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ],
                      // ),
                      CustomText(
                        text: 'Subtitle',
                        fontFamily: 'DM Sans',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: OTTColors.preferredServices,
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

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    String? count,
    bool isMobile,
  ) {
    return Row(
      children: [
        Container(
          width: 4,
          height: Get.height * 0.040,
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
          fontSize: 20,
        ),
        Spacer(),
        CustomText(
          text: 'See All',
          fontFamily: 'DM Sans',
          fontSize: 15,
          color: OTTColors.buttoncolour,
        ),
      ],
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
          text: 'Kalank Chapter 1 Trailer - Telugu | Rishab Shetty',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: OTTColors.whiteColor,
        ),
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
      height: itemHeight, // fixes height of ListView
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        // padding: const EdgeInsets.symmetric(horizontal: 8),
        separatorBuilder: (context, index) =>
            SizedBox(width: isMobile ? 8 : 12),
        itemBuilder: (context, index) {
          final colors = [
            const Color(0xFFc41e3a),
            const Color(0xFFff6b35),
            const Color(0xFFf7b801),
            const Color(0xFF8b4513),
            const Color(0xFF704214),
            const Color(0xFFc41e3a),
          ];

          return ClipRRect(
            borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
            child: Container(
              width: itemWidth,
              height: itemHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
                color: colors[index % colors.length],
              ),
              child: Center(
                child: Text(
                  'Photo ${index + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 10 : 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildParentsGuide(BuildContext context, bool isMobile) {
    final items = [
      {
        'title': 'Sex and Nudity',
        'rating': 'None',
        'color': const Color(0xFF27ae60),
      },
      {
        'title': 'Violence and Gore',
        'rating': 'Moderate',
        'color': const Color(0xFFe67e22),
      },
      {
        'title': 'Profanity',
        'rating': 'Mild',
        'color': const Color(0xFFf39c12),
      },
      {
        'title': 'Alcohol, Drug & Smoking',
        'rating': 'Moderate',
        'color': const Color(0xFFe67e22),
      },
      {
        'title': 'Frightening and Intense Scenes',
        'rating': 'Moderate',
        'color': const Color(0xFFe67e22),
      },
    ];

    return Column(
      children: items.map((item) {
        final title = item['title'] as String;
        final rating = item['rating'] as String;
        final color = item['color'] as Color;

        return Padding(
          padding: EdgeInsets.only(bottom: isMobile ? 12 : 16),
          child: Row(
            children: [
              Container(
                width: isMobile ? 24 : 28,
                height: isMobile ? 24 : 28,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                child: Center(
                  child: Text(
                    title[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 10 : 12,
                    ),
                  ),
                ),
              ),
              SizedBox(width: isMobile ? 12 : 16),
              Row(
                children: [
                  CustomText(
                    text: "$title: ",
                    fontSize: isMobile ? 14 : 16,
                    color: OTTColors.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: rating,
                    fontSize: isMobile ? 14 : 16,
                    color: OTTColors.preferredServices,
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
