import 'dart:ui';
import 'package:find_my_series/Controller/Add%20to%20watch%20list/addToWatchListController.dart';
import 'package:find_my_series/Screens/Born%20Today/bornTodayScreen.dart';
import 'package:find_my_series/Screens/Celebrity%20Details/celebrityDetails.dart';
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
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
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
  final AddToWatchlistController objAddToWatchlistController = Get.put(AddToWatchlistController());

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

  final List<Map<String, dynamic>> bornToday = [
    {
      "title": "Shahrukh Khan",
      "subtitle": "54 Years",
      "year": "54 Years",
      "rating": "UA 16+",
      "duration": "2h 45m",
      "score": "8.7",
      "poster": "assets/born1.png",
      "bookmarked": false,
    },
    {
      "title": "Varun Dhawan",
      "subtitle": "34 Years",
      "year": "34 Years",
      "rating": "UA 12+",
      "duration": "2h 41m",
      "score": "8.5",
      "poster": "assets/born2.png",
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

  final List<Map<String, dynamic>> comingSoon = [
    {
      "title": "War 2",
      // "subtitle": "Dhadak 2",
      "year": "2025",
      "rating": "UA 16+",
      "duration": "2h 45m",
      "score": "8.7",
      "poster": "assets/cs1.png",
      "bookmarked": false,
    },
    {
      "title": "Kingdom",
      // "subtitle": "Raid 2",
      "year": "2022",
      "rating": "UA 12+",
      "duration": "12 Episodes",
      "score": "8.5",
      "poster": "assets/cs2.png",
      "bookmarked": false,
    },
  ];

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
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Movie Slider
                SizedBox(
                  height: height * 0.7,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: movieImages.length,
                    itemBuilder: (context, index) {
                      return _buildMovieCard(
                        context,
                        width,
                        height,
                        movieImages[index],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),

                /// Page Indicator
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: movieImages.length,
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
                popularCelebritiesListView(popularCelebrities, width, height),

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
                _bornTodayListView(bornToday, width, height),

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
                _nowStreamingListView(nowStreaming, width, height),

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
                _comingSoonListView(comingSoon, width, height),
                const SizedBox(height: 20),

                // Latest News
                const SizedBox(height: 30),
                _sectionHeader("Latest News", "Top and Hot news for you",onSeeAll: () {
                  Get.to(NewsScreen());
                },),
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
          ),
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
                  Get.to(MovieDetailsScreen(movieId: "1",));
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
                        // Bookmark Icon with API call
                        GetBuilder<AddToWatchlistController>(
                          builder: (controller) {
                            return GestureDetector(
                              onTap: () async {
                                // Get the movie ID from your item - MAKE SURE THIS EXISTS
                                String movieId = item["id"]?.toString() ?? item["movieId"]?.toString() ?? "";
                                
                                if (movieId.isEmpty) {
                                  print("❌ Error: No movie ID found in item: $item");
                                  return;
                                }
                                
                                print("🎯 Adding movie to watchlist: $movieId");
                                
                                // Call the API
                                await controller.addToWatchlistFunction(movieId, context);
                                
                                // Update local UI state after API call
                                setState(() {
                                  item["bookmarked"] = !(item["bookmarked"] ?? false);
                                });
                              },
                              child: controller.isLoading.value 
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB968F0)),
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
    List<Map<String, dynamic>> items,
    double width,
    double height,
  ) {
    return SizedBox(
      height: height * 0.33, // 👈 decreased total card height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
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
                  Get.to(CelebrityDetails(celebrityId: '2',));
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
                          .fill, // 👈 keeps image aspect ratio, no stretch
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
    return SizedBox(
      height: height * 0.39,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            margin: EdgeInsets.only(right: index == items.length - 1 ? 0 : 16),
            child: _bornTodayCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _bornTodayCardDesign(
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
                  Get.to(CelebrityDetails(celebrityId: '1',));
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
                      Text(
                        item["year"] ?? "",
                        style: TextStyle(
                          color: OTTColors.preferredServices,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          // Favorite button + text
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
                          Spacer(),
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
            child: _nowStreamingCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _nowStreamingCardDesign(
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
                      scale: 1,
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

  // Coming Soon

  Widget _comingSoonListView(
    List<Map<String, dynamic>> items,
    double width,
    double height,
  ) {
    return SizedBox(
      height: height * 0.43,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            margin: EdgeInsets.only(right: index == items.length - 1 ? 0 : 16),
            child: _comingSoonCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _comingSoonCardDesign(
    Map<String, dynamic> item,
    double width,
    double height,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: CustomText(
            text: "${DateFormat('MMM d').format(DateTime.now())}",
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
        ),
      ],
    );
  }

  Widget _buildMovieCard(
    BuildContext context,
    double width,
    double height,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: () {
        Get.to(MovieDetailsScreen(movieId: "1",));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                width: width,
                height: height * 0.9,
                fit: BoxFit.cover,
              ),
            ),
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
            Positioned(
              top: 16,
              right: 16,
              child: Row(
                children: [
                  const CustomText(
                    text: "Watch on Netflix",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/netflix.png',
                    height: height * 0.07,
                    width: width * 0.11,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "KANTARA",
                    style: TextStyle(
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
                      _buildGenreChip("Action"),
                      _buildGenreChip("Drama"),
                      _buildGenreChip("Adventure"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        color: Colors.white70,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      const CustomText(
                        text: "216 Likes",
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                      const Spacer(),
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

  Widget _buildGenreChip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white30),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white70, fontSize: 12),
      ),
    );
  }
}
