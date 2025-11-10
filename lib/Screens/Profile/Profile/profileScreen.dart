// ignore_for_file: prefer_interpolation_to_compose_strings, deprecated_member_use

import 'dart:ui';
import 'package:find_my_series/Screens/Profile/Favourite%20People/favouritePeopleScreen.dart';
import 'package:find_my_series/Screens/Profile/Get%20Genres/getAllPrefGenresScreen.dart';
import 'package:find_my_series/Screens/Profile/Get%20Language%20Preferences/getLanguagePrefScreen.dart';
import 'package:find_my_series/Screens/Profile/OTT%20Preferences/ottPreferenceController.dart';
import 'package:find_my_series/Screens/Profile/OTT%20Preferences/ottPreferenceScreen.dart';
import 'package:find_my_series/Screens/Profile/Rating%20History/ratingHistoryScreen.dart';
import 'package:find_my_series/Screens/Profile/Recently%20Viewed/recentlyViewedScreen.dart';
import 'package:find_my_series/Screens/Profile/Update%20Profile/updateProfileScreen.dart';
import 'package:find_my_series/Screens/Profile/Watch%20History/watchHistoryScreen.dart';
import 'package:find_my_series/Screens/Profile/watch%20list/watchListScreen.dart';
import 'package:find_my_series/Screens/Settings/Settings/settingScreen.dart';
import 'package:find_my_series/auth/Prefered%20Service/Preferred%20Services/preferedServicesController.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Map<String, dynamic>> recentlyViewedMovies = [
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

  final List<Map<String, dynamic>> watchHistorylist = [
    {
      "title": "TEHRAN",
      "subtitle": "Tehran",
      "year": "2025",
      "rating": "UA 16+",
      "rated": "Rated: ⭐10",
      "score": "8.7",
      "poster": "assets/thriller.png",
      "bookmarked": false,
    },
  ];

  final List<Map<String, dynamic>> ratinglist = [
    {
      "title": "TEHRAN",
      "subtitle": "Tehran",
      "year": "2025",
      "rating": "UA 16+",
      "rated": "Rated: ⭐10",
      "score": "8.7",
      "poster": "assets/thriller.png",
      "bookmarked": false,
    },
  ];

  final List<Map<String, dynamic>> allwatchList = [
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

  final Ottpreferencecontroller objOttpreference = Get.put(Ottpreferencecontroller());


  // @override
  // void initState() {
  //   super.initState();
  //   objOttpreference.fetchPreferredPlatforms(context);
    
  // }

  late List<Map<String, dynamic>> items;

  @override
  void initState() {
    super.initState();
    objOttpreference.fetchPreferredPlatforms(context);

    items = [
      {"title": "Lists", "count": 1},
      {"title": "Reviews", "count": 6},
      {"title": "Interests", "count": 15},
      {"title": "Language Preferences", "count": 3},
      {"title": "OTT Preferences", "count": objOttpreference.ottPreferenceList.length.toString()},
      {"title": "Favorite People", "count": 3},
      {"title": "Check-ins", "count": 5},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingSvg: 'assets/logo.svg',
        leadingImageHeight: 31,
        leadingImageWidth: 132,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const SettingScreen());
            },
            icon: Icon(Icons.settings, color: OTTColors.whiteColor),
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

          /// ✅ Foreground content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// ✅ Profile Card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.01),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /// ✅ Profile Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/show.png',
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 16),

                              /// ✅ Profile Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: 'MathewWade-45',
                                      color: OTTColors.whiteColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "DM Sans",
                                    ),
                                    const SizedBox(height: 4),
                                    CustomText(
                                      text:
                                          'Joined: ${DateFormat('MMMM dd, yyyy').format(DateTime(2025, 7, 15))}',
                                      color: OTTColors.preferredServices
                                          .withOpacity(0.75),
                                      fontSize: 16,
                                      fontFamily: "DM Sans",
                                    ),
                                    const SizedBox(height: 6),
                                    CustomText(
                                      text: 'Edit Profile',
                                      color: OTTColors.buttoncolour,
                                      fontSize: 15,
                                      fontFamily: "DM Sans",
                                      onTap: () {
                                        Get.to(ProfileUpdatePage());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ✅ Stats Section (Ratings, Watchlists, Check-ins)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatBox('290', 'Ratings'),
                        _buildStatBox('160', 'Watchlists'),
                        _buildStatBox('18', 'Check-ins'),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Title Row recently reviewed
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
                          text: 'Recently Viewed',
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
                            Get.to(const Recentlyviewedscreen());
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    __recentlyViewed(recentlyViewedMovies, width, height),

                    const SizedBox(height: 15),

                    //........................  Watch history ..........................
                    const SizedBox(height: 15),
                    // Title Row
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
                          text: 'Watch History',
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
                            Get.to(const Watchhistoryscreen());
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    __watchHistory(watchHistorylist, width, height),
                    const SizedBox(height: 15),

                    //........................  Rating history ..........................

                    // Title Row
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
                          text: 'Ratings',
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
                            Get.to(const Ratinghistoryscreen());
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    __ratingList(ratinglist, width, height),
                    const SizedBox(height: 15),

                    //........................  Watch list ..........................

                    // Title Row
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
                          text: 'Watchlist',
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
                            Get.to(const WatchlistScreen());
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    __watchList(watchHistorylist, width, height),
                    const SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: double.infinity,
                          height: height * 0.063,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(
                              0.07,
                            ), // translucent white
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Lists",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                children: const [
                                  Text(
                                    "1",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white70,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                 
                       const SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: double.infinity,
                          height: height * 0.063,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(
                              0.07,
                            ), // translucent white
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Reviews",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                children: const [
                                  Text(
                                    "6",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white70,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                 
                   const SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(GetAllSavedGenresScreen());
                          },
                          child: Container(
                            width: double.infinity,
                            height: height * 0.063,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                0.07,
                              ), // translucent white
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Interests",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "15",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white70,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                 
                     const SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(GetLanguagePrefScreen());
                          },
                          child: Container(
                            width: double.infinity,
                            height: height * 0.063,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                0.07,
                              ), // translucent white
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Language Preferences",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "1",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white70,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                 
                       const SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(GetOTTPlatformPrefScreen());
                          },
                          child: Container(
                            width: double.infinity,
                            height: height * 0.063,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                0.07,
                              ), // translucent white
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                 text: "OTT Preferences",
                                   color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Dm Sans",
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                     text: objOttpreference.ottPreferenceList.length.toString(),
                                      color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "DM Sans",
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white70,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                 
                  const SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(Favouritepeoplescreen());
                          },
                          child: Container(
                            width: double.infinity,
                            height: height * 0.063,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                0.07,
                              ), // translucent white
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Favourite People",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      "1",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white70,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                 
                       const SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: double.infinity,
                          height: height * 0.063,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(
                              0.07,
                            ), // translucent white
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Check-ins",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(
                                children: const [
                                  Text(
                                    "5",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white70,
                                    size: 16,
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
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Reusable Stats Box Widget
  Widget _buildStatBox(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            CustomText(
              text: value,
              color: OTTColors.buttoncolour,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'DM Sans',
            ),
            const SizedBox(height: 4),
            CustomText(
              text: title,
              color: OTTColors.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }

  // Recently Viewed

  Widget __recentlyViewed(
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
            child: _recentlyViewedCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _recentlyViewedCardDesign(
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

  // Watch history

  Widget __watchHistory(
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
            child: _watchHistoryCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _watchHistoryCardDesign(
    Map<String, dynamic> item,
    double width,
    double height,
  ) {
    return Container(
      width: width * 0.43,
      // height: 10,
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
            // Info with Glassmorphism
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  width: width * 0.9,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
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
                        text: item["rated"] ?? "",
                        color: OTTColors.buttoncolour,
                        fontSize: 12,
                        fontFamily: "DM Sans",
                        fontWeight: FontWeight.w500,
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

  // Total Ratings

  Widget __ratingList(
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
            child: _ratingListCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _ratingListCardDesign(
    Map<String, dynamic> item,
    double width,
    double height,
  ) {
    return Container(
      width: width * 0.43,
      // height: 10,
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
            // Info with Glassmorphism
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  width: width * 0.9,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
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
                        text: item["rated"] ?? "",
                        color: OTTColors.buttoncolour,
                        fontSize: 12,
                        fontFamily: "DM Sans",
                        fontWeight: FontWeight.w500,
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

  // Total Ratings

  Widget __watchList(
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
            child: _watchListCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _watchListCardDesign(
    Map<String, dynamic> item,
    double width,
    double height,
  ) {
    return Container(
      width: width * 0.43,
      // height: 10,
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
            // Info with Glassmorphism
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  width: width * 0.9,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
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
                        text: item["rated"] ?? "",
                        color: OTTColors.buttoncolour,
                        fontSize: 12,
                        fontFamily: "DM Sans",
                        fontWeight: FontWeight.w500,
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
