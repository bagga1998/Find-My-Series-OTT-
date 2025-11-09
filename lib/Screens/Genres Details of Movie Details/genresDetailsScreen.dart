import 'dart:ui';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GenresDetailsScreen extends StatefulWidget {
  const GenresDetailsScreen({super.key});

  @override
  State<GenresDetailsScreen> createState() => _GenresDetailsScreenState();
}

class _GenresDetailsScreenState extends State<GenresDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
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
            icon: const Icon(Icons.share_outlined, color: OTTColors.whiteColor),
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

           // ✅ Add a dark overlay to make content visible
  /// ✅ Glassmorphism Overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              
            ),
          ),

          /// ✅ Foreground Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Thriller',
                      fontFamily: 'DM Sans',
                      fontSize: isTablet ? 24 : 21,
                      fontWeight: FontWeight.w700,
                      color: OTTColors.whiteColor,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.25,
                      child: Image.asset(
                        'assets/thriller.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildGenreChip('Genres'),
                    const SizedBox(height: 16),

                    CustomText(
                      text:
                          'The action epic genre delivers intense, fast-moving stories set against massive backdrops. These tales often cover wide time periods, historic settings, and unforgettable characters locked in major conflicts. Traditionally, an epic focuses on the heroic journey of one person—or a group—whose actions determine the destiny of many.',
                      fontFamily: 'DM Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: OTTColors.preferredServices,
                    ),
                    const SizedBox(height: 16),

                    // Add to Watchlist Button
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

                    // Popular thriller movies Guide Section
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
                          text: "Popular Thriller Movies",
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
                    const SizedBox(height: 20),

                    _popularThrillerMovies(thrillerMovies, width, height),
                  
                    const SizedBox(height: 20),


                       // Popular thriller show Guide Section
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
                          text: "Popular Thriller Show",
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
                  
                    const SizedBox(height: 20),

                    _popularThrillerShows(thrillerMovies, width, height),

                    const SizedBox(height: 20),

                     // Coming soon Guide Section
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
                          text: "Coming Soon",
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
                    const SizedBox(height: 20),

                    // _popularThrillerShows(thrillerMovies, width, height),
                    _comingSoon(thrillerMovies, width, height),

                    const SizedBox(height: 20),

                  
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

    // Popular Thriller Movies List

  Widget _popularThrillerMovies(
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
            child: _popularThrillerMoviesCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _popularThrillerMoviesCardDesign(
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


    // Popular Thriller Show List

  Widget _popularThrillerShows(
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
            child: _popularThrillerShowsCardDesign(item, width, height),
          );
        },
      ),
    );
  }

  Widget _popularThrillerShowsCardDesign(
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


    // Coming soon List

  Widget _comingSoon(
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





}
