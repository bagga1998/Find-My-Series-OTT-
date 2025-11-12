import 'dart:ui';
import 'package:find_my_series/Controller/Add%20to%20watch%20list/addToWatchListController.dart';
import 'package:find_my_series/Screens/Born%20Today/bornTodayScreen.dart';
import 'package:find_my_series/Screens/Celebrity%20Details/celebrityDetails.dart';
import 'package:find_my_series/Screens/Home%20Screen/homeScreenController.dart';
import 'package:find_my_series/Screens/Home%20Screen/homeScreenModel.dart';
import 'package:find_my_series/Screens/Movie%20details%20screen/movieDetailsScreen.dart';
import 'package:find_my_series/Screens/News/All%20News/newsScreen.dart';
import 'package:find_my_series/Screens/Notifications/notificationScreen.dart';
import 'package:find_my_series/Screens/Now%20Streaming/nowStramingScreen.dart';
import 'package:find_my_series/Screens/Popular%20Celebrities/popularCelebritiesScreen.dart';
import 'package:find_my_series/Screens/Popular%20Indian%20Movies/popularIndianMoviesScreen.dart';
import 'package:find_my_series/Screens/Popular%20TV%20Shows/popularTvShowsScreen.dart';
import 'package:find_my_series/Screens/Releasing%20Today/releasingTodayScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/dropdown.dart';
import 'package:find_my_series/widgets/font-styles.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isWatchlisted = false;
  final PageController _pageController = PageController();
  final AddToWatchlistController objAddToWatchlistController = Get.put(
    AddToWatchlistController(),
  );
  final HomePageController homePageController = Get.put(HomePageController());

  final List<String> movieImages = [
    'assets/support.png',
    'assets/support.png',
    'assets/support.png',
  ];

  String? selectedCategory;
  final List<String> categories = [
    'All',
    'Action',
    'Comedy',
    'Drama',
    'Thriller',
  ];

  String? topPicksPref;
  final List<String> topPicksPreferences = [
    'Preference 1',
    'Preference 2',
    'Preference 3',
    'Preference 4',
    'Preference 5',
  ];

  final List<Map<String, dynamic>> movies = [
    {
      "title": "TEHRAN",
      "subtitle": "Tehran",
      "year": "2025",
      "rating": "UA 16+",
      "duration": "2h 45m",
      "score": "8.7",
      "poster": "assets/movie1.png",
      "bookmarked": false,
    },
    {
      "title": "HINDI MEDIUM",
      "subtitle": "Hindi Medium",
      "year": "2022",
      "rating": "UA 12+",
      "duration": "2h 41m",
      "score": "8.5",
      "poster": "assets/movie2.png",
      "bookmarked": false,
    },
  ];

  final List<Map<String, dynamic>> tvShows = [
    {
      "title": "TEHRAN",
      "subtitle": "Tehran",
      "year": "2025",
      "rating": "UA 16+",
      "duration": "2h 45m",
      "score": "8.7",
      "poster": "assets/tv1.png",
      "bookmarked": false,
    },
  ];


  final List<Map<String, dynamic>> releasingToday = [
    {
      "title": "Dhadak 2",
      "subtitle": "Dhadak 2",
      "year": "2025",
      "rating": "UA 16+",
      "duration": "2h 45m",
      "score": "8.7",
      "poster": "assets/releasing1.png",
      "bookmarked": false,
    },
    {
      "title": "Raid 2",
      "subtitle": "Raid 2",
      "year": "2022",
      "rating": "UA 12+",
      "duration": "2h 41m",
      "score": "8.5",
      "poster": "assets/releasing2.png",
      "bookmarked": false,
    },
  ];


  final List<Map<String, dynamic>> topPickss = [
    {
      "title": "Hello Mini 3",
      "subtitle": "Tehran",
      "year": "2025",
      "rating": "Season 3",
      "duration": "2h 45m",
      "score": "8.7",
      "poster": "assets/topPick1.png",
      "bookmarked": false,
    },
    {
      "title": "Hichki",
      "subtitle": "Hindi Medium",
      "year": "2022",
      "rating": "UA 12+",
      "duration": "2h 41m",
      "score": "8.5",
      "poster": "assets/topPick2.png",
      "bookmarked": false,
    },
  ];

  final List<Map<String, dynamic>> nowStreaming = [
    {
      "title": "Plat Number 302",
      // "subtitle": "Tehran",
      "year": "2025",
      "rating": "Season 3",
      "duration": "2h 45m",
      "score": "8.7",
      "poster": "assets/preferredServices/NS1.png",
      "bookmarked": false,
    },
    {
      "title": "Kaal Chakra",
      // "subtitle": "Hindi Medium",
      "year": "2022",
      "rating": "UA 12+",
      "duration": "2h 41m",
      "score": "8.5",
      "poster": "assets/preferredServices/NS2.png",
      "bookmarked": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    homePageController.fetchHomePageData(context);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leadingSvg: 'assets/logo.svg',
        customBackgroundColor: OTTColors.black1,
        leadingImageHeight: 31,
        leadingImageWidth: 132,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const NotificationScreen());
            },
            icon: Icon(
              Icons.notifications_none_outlined,
              color: OTTColors.preferredServices,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          SvgPicture.asset(
            'assets/background.svg',
            width: width,
            fit: BoxFit.cover,
          ),

          // Dark overlay for readability
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5),
          ),
          Obx(() {
            if (homePageController.isLoading.value) {
              return ListView.builder(
                itemCount: 6, // number of shimmer placeholders
                itemBuilder: (context, index) {
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
                          // Shimmer Image Placeholder
                          Container(
                            margin: EdgeInsets.all(8),
                            height: height * 0.12,
                            width: height * 0.10,
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          SizedBox(width: width * 0.03),

                          // Shimmer Text Section
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
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Movie Slider
                  Obx(() {
                    if (homePageController.topBannersList.isNotEmpty) {
                      return Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 15 / 20,
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount:
                                  homePageController.topBannersList.length,
                              itemBuilder: (context, index) {
                                final movie =
                                    homePageController.topBannersList[index];
                                return _buildMovieCard(
                                  context,
                                  width,
                                  height,
                                  movie,
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// Page Indicator
                          Center(
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: homePageController.topBannersList.length,
                              effect: ExpandingDotsEffect(
                                activeDotColor: OTTColors.buttoncolour,
                                dotColor: Colors.white24,
                                dotHeight: 8,
                                dotWidth: 8,
                                spacing: 6,
                                expansionFactor: 3,
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink(); // hides both slider & indicator when empty
                    }
                  }),

                  /// Popular Movies Section
                  _sectionHeader(
                    "Popular Indian Movies",
                    "This week's top Indian movies",
                    onSeeAll: () {
                      Get.to(PopularIndianMoviesScreen());
                    },
                  ),
                  const SizedBox(height: 10),
                  _categoryDropdown(width, height),
                  const SizedBox(height: 20),
                  _popularIndianMoviesListView(movies, width, height),

                  const SizedBox(height: 30),

                  /// Popular TV Shows Section
                  _sectionHeader(
                    "Popular Indian TV Shows",
                    "This week's top Indian TV Shows",
                    onSeeAll: () {
                      Get.to(PopularTvShowsScreen());
                    },
                  ),
                  const SizedBox(height: 10),
                  _categoryDropdown(width, height),
                  const SizedBox(height: 20),
                  _indianTVshowsListView(tvShows, width, height),

                  const SizedBox(height: 30),
                  if (homePageController.popularCelebritiesList.isNotEmpty) ...[
                    // Popular Celebrities
                    _sectionHeader(
                      "Popular Celebrities",
                      "This week's top Indian Stars",
                      onSeeAll: () {
                        Get.to(PopularCelebritiesScreen());
                      },
                    ),
                    const SizedBox(height: 10),
                    _celebritiesDropdown(width, height),
                    const SizedBox(height: 20),
                    popularCelebritiesListView(
                      homePageController.popularCelebritiesList
                          .cast<PopularCelebrity>(),
                      width,
                      height,
                    ),
                  ],

                  // Releasing Today
                  const SizedBox(height: 30),
                  _sectionHeader(
                    "Releasing Today",
                    "List of Indian Movies releasing today",
                    onSeeAll: () {
                      Get.to(const NewScreen());
                    },
                  ),
                  const SizedBox(height: 20),
                  _releasingTodayListView(releasingToday, width, height),

                  // Born Today
                  const SizedBox(height: 30),
                  _sectionHeader(
                    "Born Today",
                    "This week’s top Indian stars",
                    onSeeAll: () {
                      Get.to(const BornTodayScreen());
                    },
                  ),
                  const SizedBox(height: 20),

                  /// Born Today Section
                  /// Born Today Section
                  Obx(() {
                    if (homePageController.bornTodayList.isNotEmpty) {
                      // Convert model list into map list for your card widget
                      final bornTodayItems = homePageController.bornTodayList
                          .map((e) {
                            return {
                              "id": e.id,
                              "title": e.name,
                              "year": e.roleCategory,
                              "photoUrl": e.photoUrl,
                              "isFavorite": false,
                            };
                          })
                          .toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8,
                            ),
                            child: CustomText(
                              text: "Born Today",
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          _bornTodayListView(bornTodayItems, width, height),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),

                  // Top Picks
                  const SizedBox(height: 30),
                  _sectionHeader(
                    "Top Picks for you",
                    "TV shows and movies just for you",
                  ),
                  const SizedBox(height: 10),
                  _editPreferencesInTopPicksDropdown(width, height),
                  const SizedBox(height: 20),
                  _topPicksListView(topPickss, width, height),

                  // Now Streaming
                  const SizedBox(height: 30),
                  _sectionHeader(
                    "Now Streaming",
                    "TV shows/movies on your favorite OTT",
                    onSeeAll: () {
                      Get.to(const NowStramingScreen());
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Image.asset(
                        'assets/preferredServices/chaupal.png',
                        height: height * 0.06,
                      ),
                      SizedBox(width: 10),
                      Image.asset(
                        'assets/preferredServices/jioHotStar.png',
                        height: height * 0.06,
                      ),
                      SizedBox(width: 10),
                      Image.asset(
                        'assets/preferredServices/netflix.png',
                        height: height * 0.06,
                      ),
                      SizedBox(width: 10),
                      Image.asset(
                        'assets/preferredServices/sonyLiv.png',
                        height: height * 0.06,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    // ✅ Hide UI if list is empty
                    if (homePageController.nowStreamingList.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    // ✅ Convert RxList<dynamic> → List<ComingSoon>
                    final List<dynamic> nowStreamingItems =
                        homePageController.nowStreamingList
                            .map((e) => e as NowStreaming)
                            .toList();

                    return _nowStreamingListView(
                      nowStreamingItems,
                      width,
                      height,
                    );
                  }),

                  // Coming Soon
                  const SizedBox(height: 30),
                  _sectionHeader(
                    "Coming Soon",
                    "Indian Movies/TV shows coming soon",
                    onSeeAll: () {
                      Get.to(const NewScreen());
                    },
                  ),
                  const SizedBox(height: 20),

                  Obx(() {
                    // ✅ Hide UI if list is empty
                    if (homePageController.comingSoonList.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    // ✅ Convert RxList<dynamic> → List<ComingSoon>
                    final List<dynamic> comingSoonItems =
                        homePageController.comingSoonList
                            .map((e) => e as ComingSoon)
                            .toList();

                    return _comingSoonListView(
                      comingSoonItems,
                      width,
                      height,
                    );
                  }),

                  // Latest News
                  const SizedBox(height: 30),
                  _sectionHeader(
                    "Latest News",
                    "Top and Hot news for you",
                    onSeeAll: () {
                      Get.to(NewsScreen());
                    },
                  ),
                  const SizedBox(height: 20),
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
                                'assets/movie1.png',
                                height: Get.height * 0.2,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                children: [
                                  CustomText(
                                    text:
                                        'Maharani” Renewed for Season 4, Huma Qureshi Returns as Rani Bharti',
                                    fontFamily: 'DM Sans',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: OTTColors.white,
                                  ),

                                  CustomText(
                                    text:
                                        'Political drama Maharani is coming back with its fourth season, with Huma Qureshi reprising the powerful role',
                                    fontFamily: 'DM Sans',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    maxLines: 5,
                                    color: OTTColors.white,
                                  ),
                                ],
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
          }),
        ],
      ),
    );
  }

  Widget _sectionHeader(
    String title,
    String subtitle, {
    VoidCallback? onSeeAll,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFB968F0),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  color: OTTColors.buttoncolour,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  fontFamily: 'DM Sans',
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: subtitle,
                  color: const Color(0xFF9E9E9E),
                  fontSize: 13,
                  fontFamily: 'DM Sans',
                ),
              ],
            ),
          ],
        ),

        /// 👇 Show "See All" only if onSeeAll is provided
        if (onSeeAll != null)
          InkWell(
            onTap: onSeeAll,
            child: const Text(
              "See All",
              style: TextStyle(
                color: Color(0xFFB968F0),
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: 'DM Sans',
              ),
            ),
          ),
      ],
    );
  }

  // All Drop-downs

  Widget _categoryDropdown(double width, double height) {
    return SizedBox(
      width: width * 0.5,
      child: CustomDropdownButton2(
        hint: const Text(
          'Select Category',
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

  Widget _celebritiesDropdown(double width, double height) {
    return SizedBox(
      width: width * 0.5,
      child: CustomDropdownButton2(
        hint: const Text(
          'Select Category',
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

  Widget _editPreferencesInTopPicksDropdown(double width, double height) {
    return SizedBox(
      width: width * 0.5,
      child: CustomDropdownButton2(
        hint: const Text(
          'Edit Preferences',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        value: topPicksPref,
        dropdownItems: topPicksPreferences,
        onChanged: (value) {
          setState(() {
            topPicksPref = value;
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

  // Indian Movies

  Widget _popularIndianMoviesListView(
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
            child: _popularIndianMoviesCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _popularIndianMoviesCardDesign(
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
                  Get.to(MovieDetailsScreen(movieId: "1"));
                },
                child: Container(
                  height: height * 0.23,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(item["poster"] ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            // Info with Glassmorphism
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
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
                            item["certificate"] ?? "",
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

  // Popular Indian TV shows

  Widget _indianTVshowsListView(
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
            child: _indianTVshowsCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _indianTVshowsCardDesign(
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
                  Get.to(MovieDetailsScreen(movieId: "1"));
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
                          // Bookmark Icon with API call
                          GetBuilder<AddToWatchlistController>(
                            builder: (controller) {
                              return GestureDetector(
                                onTap: () async {
                                  // Get the movie ID from your item - MAKE SURE THIS EXISTS
                                  String movieId =
                                      item["id"]?.toString() ??
                                      item["movieId"]?.toString() ??
                                      "";

                                  if (movieId.isEmpty) {
                                    print(
                                      "❌ Error: No movie ID found in item: $item",
                                    );
                                    return;
                                  }

                                  print(
                                    "🎯 Adding movie to watchlist: $movieId",
                                  );

                                  // Call the API
                                  await controller.addToWatchlistFunction(
                                    movieId,
                                    context,
                                  );

                                  // Update local UI state after API call
                                  setState(() {
                                    item["bookmarked"] =
                                        !(item["bookmarked"] ?? false);
                                  });
                                },
                                child: controller.isLoading.value
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Color(0xFFB968F0),
                                              ),
                                        ),
                                      )
                                    : Icon(
                                        item["bookmarked"] == true
                                            ? Icons.bookmark
                                            : Icons.bookmark_border,
                                        color: item["bookmarked"] == true
                                            ? const Color(0xFFB968F0)
                                            : Colors.grey[300],
                                      ),
                              );
                            },
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
  } // Popular celebrities

  Widget popularCelebritiesListView(
    List<PopularCelebrity> items,
    double width,
    double height,
  ) {
    return SizedBox(
      height: height * 0.35, // 👈 total card height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        itemBuilder: (context, index) {
          final item = items[index];

          // ✅ Debug log to check fetched data
          print("Celebrity #$index → ${item.name} (${item.roleCategory})");

          return Container(
            margin: EdgeInsets.only(right: width * 0.04),
            child: _popularCelebritiesCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _popularCelebritiesCardDesign(
    PopularCelebrity item,
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
            // 👤 Celebrity Photo
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(CelebrityDetails(celebrityId: item.id.toString()));
                },
                child: Container(
                  height: height * 0.22,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(item.photoUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),

            // ℹ️ Info Section
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
                      // 🎬 Name
                      Text(
                        item.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.038,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: height * 0.004),

                      // 🎭 Role Category
                      Text(
                        item.roleCategory,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: width * 0.032,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: height * 0.006),

                      // ❤️ Favourite Row
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("Favourite tapped for: ${item.name}");
                            },
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white70,
                              size: width * 0.060,
                            ),
                          ),
                          const Spacer(),
                          CustomText(
                            text: 'Add to Favourite',
                            fontSize: 13,
                            fontFamily: 'DM Sans',
                            color: OTTColors.background,
                            fontWeight: FontWeight.w500,
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

  // Releasing Today

  Widget _releasingTodayListView(
    List<Map<String, dynamic>> items,
    double width,
    double height,
  ) {
    return SizedBox(
      height: height * 0.39,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            margin: EdgeInsets.only(right: index == items.length - 1 ? 0 : 16),
            child: _releasingTodayCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _releasingTodayCardDesign(
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
                  Get.to(MovieDetailsScreen(movieId: "1"));
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
                        item["title"],
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
                              color: OTTColors.preferredServices,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '•',
                            style: TextStyle(
                              color: OTTColors.preferredServices,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item["rating"] ?? "",
                            style: TextStyle(
                              color: OTTColors.preferredServices,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          CustomText(
                            text: item["duration"] ?? "",
                            color: OTTColors.preferredServices,
                            fontSize: 15,
                          ),
                          Spacer(),
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
                                  : OTTColors.preferredServices,
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

  // Born Today
  Widget _bornTodayListView(
    List<Map<String, dynamic>> items,
    double width,
    double height,
  ) {
    // ✅ Check if list is empty — return SizedBox.shrink() to hide UI
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: height * 0.39,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            margin: EdgeInsets.only(right: index == items.length - 1 ? 0 : 16),
            child: _bornTodayCardDesign(item, width, height, context),
          );
        },
      ),
    );
  }

  Widget _bornTodayCardDesign(
    Map<String, dynamic> item,
    double width,
    double height,
    BuildContext context,
  ) {
    final imageUrl = item["photoUrl"] ?? "";

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
            // Poster Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => CelebrityDetails(celebrityId: item['id'].toString()));
                },
                child: Container(
                  height: height * 0.23,
                  width: double.infinity, // ✅ Fix overflow width
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: imageUrl.isNotEmpty
                          ? NetworkImage(imageUrl)
                          : const AssetImage('assets/images/placeholder.png')
                                as ImageProvider,
                      fit: BoxFit.cover,
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
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        item["title"] ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Year
                      Text(
                        item["year"] ?? "",
                        style: TextStyle(
                          color: OTTColors.preferredServices,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Favourite Row
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                item["isFavorite"] =
                                    !(item["isFavorite"] ?? false);
                              });
                            },
                            child: Icon(
                              item["isFavorite"] == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: item["isFavorite"] == true
                                  ? Colors.red
                                  : Colors.white70,
                              size: 18,
                            ),
                          ),
                          const Spacer(),
                          CustomText(
                            text: 'Add to Favourite',
                            fontSize: 12,
                            fontFamily: 'DM Sans',
                            color: OTTColors.background,
                            fontWeight: FontWeight.w500,
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

  // Top Picks

  Widget _topPicksListView(
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
            child: _topPicksCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _topPicksCardDesign(
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
                  Get.to(MovieDetailsScreen(movieId: "1"));
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
                        item["title"],
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

  // Now Streaming
  Widget _nowStreamingListView(
    List<dynamic> items,
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
            child: _nowStreamingCardDesign(item, width, height, context),
          );
        },
      ),
    );
  }

  Widget _nowStreamingCardDesign(
    dynamic item,
    double width,
    double height,
    BuildContext context,
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
                  Get.to(MovieDetailsScreen(movieId: item.id.toString()));
                },
                child: Container(
                  height: height * 0.23,
                  width: MediaQuery.of(context).size.width / 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: NetworkImage(item.thumbnailUrl),
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
                      // Title
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Year & Rating
                      Row(
                        children: [
                          Text(
                            item.releaseDate.year.toString(),
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
                            item.certificate.name,
                            style: TextStyle( 
                              color: Colors.grey[300],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Platform name
                      CustomText(
                        text: item.platform.name,
                        color: OTTColors.bottom,
                        fontSize: 12,
                      ),
                      const SizedBox(height: 4),

                      // Score + Bookmark
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
                                text: item.rating ?? '0.0',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // optional: you can implement a bookmark logic here
                            },
                            child: const Icon(
                              Icons.bookmark_border,
                              color: Colors.white70,
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

// Coming Soon

Widget _comingSoonListView(
  List<dynamic> items,
  double width,
  double height,
) {
  return SizedBox(
    height: height * 0.43,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index] as ComingSoon;
        return Container(
          margin: EdgeInsets.only(right: index == items.length - 1 ? 0 : 16),
          child: _comingSoonCardDesign(item, width, height),
        );
      },
    ),
  );
}

Widget _comingSoonCardDesign(
  ComingSoon item,
  double width,
  double height,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 1.0),
        child: CustomText(
          text: DateFormat('MMM d').format(DateTime.now()),
          color: OTTColors.preferredServices,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      Container(
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
                    Get.to(MovieDetailsScreen(movieId: item.id.toString()));
                  },
                  child: Container(
                    height: height * 0.23,
                    width: MediaQuery.of(context).size.width / 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(item.thumbnailUrl),
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
                          item.title,
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
                              DateFormat('yyyy').format(item.releaseDate),
                              style: TextStyle(
                                color: OTTColors.preferredServices,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '•',
                              style: TextStyle(
                                color: OTTColors.preferredServices,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              item.certificate.name,
                              style: TextStyle(
                                color: OTTColors.preferredServices,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            CustomText(
                              text: item.platform.name,
                              color: OTTColors.preferredServices,
                              fontSize: 15,
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                // If you want to toggle bookmark in the future, handle it with controller.
                              },
                              child: Icon(
                                Icons.bookmark_border,
                                color: OTTColors.preferredServices,
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
      ),
    ],
  );
}

  // ================= MOVIE CARD WIDGET =================
  Widget _buildMovieCard(
    BuildContext context,
    double width,
    double height,
    dynamic movie,
  ) {
    return GestureDetector(
      onTap: () {
        Get.to(MovieDetailsScreen(movieId: movie.id.toString()));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            // ✅ API image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                movie.thumbnailUrl,
                width: width,
                height: height * 0.9,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade900,
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.white54,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                ),
              ),
            ),

            // ✅ Platform name & icon
            Positioned(
              top: 16,
              right: 16,
              child: Row(
                children: [
                  CustomText(
                    text: "Watch on ${movie.platform.name}",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(width: 8),
                  Image.network(
                    movie.platform.iconUrl,
                    height: height * 0.07,
                    width: width * 0.11,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(),
                  ),
                ],
              ),
            ),

            // ✅ Title, genre, likes, watchlist
            Positioned(
              bottom: 16,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildGenreChip(movie.type ?? "N/A"),
                      _buildGenreChip(movie.certificate.name),
                      _buildGenreChip(movie.status.name),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      // const Icon(
                      //   Icons.favorite_border,
                      //   color: Colors.white70,
                      //   size: 20,
                      // ),
                      // const SizedBox(width: 5),
                      // CustomText(
                      //   text: "${movie.rating ?? "0"} Likes",
                      //   color: Colors.white70,
                      //   fontSize: 13,
                      // ),
                      // const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isWatchlisted = !isWatchlisted;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              isWatchlisted
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            CustomText(
                              text: "Add to Watchlist",
                              color: isWatchlisted
                                  ? Colors.purpleAccent
                                  : Colors.white70,
                              fontSize: 13,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= GENRE CHIP WIDGET =================
  Widget _buildGenreChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white70, fontSize: 12),
      ),
    );
  }
}
