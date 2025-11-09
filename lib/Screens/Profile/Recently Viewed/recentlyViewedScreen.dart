import 'dart:ui';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Recentlyviewedscreen extends StatefulWidget {
  const Recentlyviewedscreen({super.key});

  @override
  State<Recentlyviewedscreen> createState() => _RecentlyviewedscreenState();
}

class _RecentlyviewedscreenState extends State<Recentlyviewedscreen> {
  final List<Map<String, String>> recentlyViewed = [
    {
      "image": "assets/movie.png",
      "title": "Dilwale",
      "subtitle": "Language: Hindi, Tamil, Telegu\n2015  •  UA 16+  •  2h 45m",
    },
    {
      "image": "assets/thriller.png",
      "title": "Kesari Chapter 2",
      "subtitle": "Language: Hindi, Tamil, Telegu\n2015  •  UA 16+  •  2h 45m",
    },
    {
      "image": "assets/shahrukh.png",
      "title": "Shahrukh Khan",
      "subtitle": "Actor, Singer",
    },
    {
      "image": "assets/genres.png",
      "title": "Action",
      "subtitle": "Genres",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: OTTColors.black1,
      appBar: CustomAppBar(
        leadingText: 'BACK TO PREVIOUS PAGE',
        leadingIcon: Icons.arrow_back_ios_new_rounded,
        showBackArrow: true,
        leadingOnPressed: Get.back,
        leadingIconSize: 18,
        leadingTextStyle: const TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
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
          /// ✅ Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              fit: BoxFit.cover,
            ),
          ),

          /// ✅ Glass blur overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            ),
          ),

          /// ✅ Foreground UI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                          width: 4,
                          height: Get.height * 0.028,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB968F0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 10),
                          CustomText(
                              text: 'Recently Reviewed ',
                              color: OTTColors.buttoncolour,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                        SizedBox(width: Get.width * 0.005),
                          CustomText(
                              text: '(16)',
                              color: OTTColors.preferredServices.withOpacity(0.6),
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                        ],
                      ),
                      Text(
                        "Clear All",
                        style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF9D4EDD),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// List of recently viewed items
                  Expanded(
                    child: ListView.builder(
                      itemCount: recentlyViewed.length,
                      itemBuilder: (context, index) {
                        final item = recentlyViewed[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                item["image"]!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              item["title"]!,
                              style: const TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              item["subtitle"]!,
                              style: const TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 13,
                                color: Colors.white70,
                                height: 1.3,
                              ),
                            ),

                            /// ✅ Updated Glassy Popup Menu
                            trailing: PopupMenuButton<String>(
                              padding: EdgeInsets.zero,
                              elevation: 0,
                              constraints: const BoxConstraints(minWidth: 190),
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: Colors.white.withOpacity(0.1),
                                ),
                              ),
                              icon: const Icon(
                                Icons.more_vert_rounded,
                                color: Colors.white70,
                              ),
                              itemBuilder: (context) => [
                                PopupMenuItem<String>(
                                  value: 'Add to Watchlist',
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      border: Border(
                                        bottom: BorderSide(
                                          color:
                                              Colors.white.withOpacity(0.08),
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    child: const Text(
                                      'Add to Watchlist',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'DM Sans',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Share Now',
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      border: Border(
                                        bottom: BorderSide(
                                          color:
                                              Colors.white.withOpacity(0.08),
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    child: const Text(
                                      'Share Now',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'DM Sans',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Add a Review',
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      border: Border(
                                        bottom: BorderSide(
                                          color:
                                              Colors.white.withOpacity(0.08),
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    child: const Text(
                                      'Add a Review',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'DM Sans',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Check In',
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                                    child: const Text(
                                      'Check In',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'DM Sans',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              onSelected: (value) {
                                // Handle menu item actions here
                              },
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
