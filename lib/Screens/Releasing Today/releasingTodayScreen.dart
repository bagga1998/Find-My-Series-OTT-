// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:ui';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Map<String, String>> releasingTodayList = [
    {
      'title': 'Dilwale',
      'language': 'Hindi, Tamil, Telugu',
      'details': '2015 • UA 16+ • 2h 45m',
      'image': 'assets/movie.png',
      'releasing': 'Releasing in Theater',
    },
    {
      'title': 'KGF 2',
      'language': 'Kannada, Hindi, Tamil',
      'details': '2022 • UA 16+ • 2h 48m',
      'image': 'assets/movie.png',
      'releasing': 'Releasing in Theater',
    },
    {
      'title': 'KGF 2',
      'language': 'Kannada, Hindi, Tamil',
      'details': '2022 • UA 16+ • 2h 48m',
      'image': 'assets/movie.png',
      'releasing': 'Releasing in Theater',
    },
  ];

  final List<Map<String, String>> comingSoonList = [
    {
      'title': 'Di Bekaraar',
      'language': 'Hindi, Tamil, Telugu',
      'details': '2021 • UA 16+ • 2 Seasons',
      'image': 'assets/show.png',
      'releasing': 'Coming Soon on OTT',
    },
    {
      'title': 'RRR 2',
      'language': 'Telugu, Hindi, Tamil',
      'details': '2025 • UA 13+ • 3h 10m',
      'image': 'assets/show.png',
      'releasing': 'Coming Soon on OTT',
    },
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
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
        customBackgroundColor: Colors.transparent,
        leadingImageHeight: 31,
        leadingImageWidth: 132,
      ),
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),

          // Foreground content
          Column(
            children: [
              SizedBox(
                height: kToolbarHeight + MediaQuery.of(context).padding.top,
              ),

              // Tab Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.white.withOpacity(0.1),
                      child: TabBar(
                        controller: tabController,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white70,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFBA66F0), Color(0xFF742DFF)],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding: const EdgeInsets.all(4),
                        tabs: const [
                          Tab(text: "Releasing Today"),
                          Tab(text: "Coming Soon"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Tab Views
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    _buildListView(releasingTodayList),
                    _buildListView(comingSoonList),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Common ListView with date section
  Widget _buildListView(List<Map<String, String>> dataList) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: dataList.length + 1,
      itemBuilder: (context, index) {
        // Add the date header above the list
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: Get.height * 0.03,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB968F0),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomText(
                    text: DateFormat('MMM dd, yyyy').format(DateTime.now()) +
                        ' (Today)',
                    color: OTTColors.buttoncolour,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          );
        }

        final item = dataList[index - 1];
        return _glassCard(
          item['title']!,
          item['language']!,
          item['details']!,
          item['image']!,
          item['releasing']!,
        );
      },
    );
  }

  // Glassmorphic card
  Widget _glassCard(
    String title,
    String language,
    String details,
    String imagePath,
    String releasing,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              // Thumbnail
              Container(
                height: Get.height * 0.15,
                width: Get.height * 0.15 * 0.7,
                color: Colors.grey.withOpacity(0.3),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.withOpacity(0.3),
                      child: const Icon(Icons.image, color: Colors.white54),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DM Sans',
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      text: "Language: $language",
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: details,
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: releasing,
                      color: OTTColors.buttoncolour,
                      fontSize: 14,
                      fontFamily: 'DM Sans',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
