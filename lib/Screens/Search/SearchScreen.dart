import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:find_my_series/widgets/textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart'; // For blur effect

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  bool _showMoreLanguages = false;
  bool _showMoreGeners = false;
  TextEditingController searchController = TextEditingController();

  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: OTTColors.black1,
      body: SafeArea(
        child: Stack(
          children: [
            // Background SVG
            SvgPicture.asset(
              'assets/background.svg',
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),

            // Foreground Content
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        // color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: CustomTextFormField(
                      label: 'Search Movie, TV Show & Celeb',
                      controller: searchController,
                      backgroundColor: Colors.transparent,
                      prefixIcon: const Icon(Icons.search),
                      iconColor: OTTColors.preferredServices,
                      textColor: OTTColors.white,
                      labelStyle: TextStyle(color: OTTColors.preferredServices),
                    ),
                  ),
                ),

                // Tabs with Glassmorphism and Gradient
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: TabBar(
                        controller: tabController,
                        labelColor: Colors.white,
                        dividerColor: Colors.transparent,
                        unselectedLabelColor: Colors.white70,
                        indicator: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFBA66F0), // #BA66F0
                              Color(0xFF742DFF), // #742DFF
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFBA66F0).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding: const EdgeInsets.all(4),
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                        tabs: const [
                          Tab(text: "All"),
                          Tab(text: "Movies"),
                          Tab(text: "Shows"),
                          Tab(text: "People"),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Tab Views
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      // All Tab
                      _buildAllContent(),
                      // Movies Tab
                      _buildMoviesContent(),
                      // Shows Tab
                      _buildShowsContent(),
                      // People Tab
                      _buildPeopleContent(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movies Section
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
            SizedBox(width: 10),
            CustomText(
              text: 'Movies',
              color: OTTColors.buttoncolour,
              fontFamily: 'DM Sans',
             fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            Spacer(),
             CustomText(
              text: '"1 Result Found"',
              color: OTTColors.preferredServices,
              fontStyle: FontStyle.italic,
              fontFamily: 'DM Sans',
             fontWeight: FontWeight.w400,
              fontSize: 16,
              
            ),
          ],
        ),
          const SizedBox(height: 16),
          _buildMovieCard("Dilwale", "Hindi, Tamil, Telegu", "2015 • UA 16+ • 2h 45m"),
          
          const SizedBox(height: 24),
          
          // Shows Section
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
            SizedBox(width: 10),
            CustomText(
              text: 'Show',
              color: OTTColors.buttoncolour,
              fontFamily: 'DM Sans',
             fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            Spacer(),
             CustomText(
              text: '"1 Result Found"',
              color: OTTColors.preferredServices,
              fontStyle: FontStyle.italic,
              fontFamily: 'DM Sans',
             fontWeight: FontWeight.w400,
              fontSize: 16,
              
            ),
          ],
        ),
          const SizedBox(height: 16),
          _buildShowCard("Di Bekaraar", "Hindi, Tamil, Telegu", "2021 • UA 16+ • 2 Seasons"),
          const SizedBox(height: 24),
          
          // People Section
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
            SizedBox(width: 10),
            CustomText(
              text: 'People',
              color: OTTColors.buttoncolour,
              fontFamily: 'DM Sans',
             fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            Spacer(),
             CustomText(
              text: '"1 Result Found"',
              color: OTTColors.preferredServices,
              fontStyle: FontStyle.italic,
              fontFamily: 'DM Sans',
             fontWeight: FontWeight.w400,
              fontSize: 16,
              
            ),
          ],
        ),
          const SizedBox(height: 16),
          _buildPeopleCard("Diljit Dosanjh", "Actor, Singer", '"I Result Found"'),
        ],
      ),
    );
  }

  Widget _buildMoviesContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
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
            SizedBox(width: 10),
            CustomText(
              text: 'Movies',
              color: OTTColors.buttoncolour,
              fontFamily: 'DM Sans',
             fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            Spacer(),
             CustomText(
              text: '1 Result Found',
              color: OTTColors.preferredServices,
              fontStyle: FontStyle.italic,
              fontFamily: 'DM Sans',
             fontWeight: FontWeight.w400,
              fontSize: 16,
              
            ),
          ],
        ),
          const SizedBox(height: 16),
          _buildMovieCard("Dilwale", "Hindi, Tamil, Telegu", "2015 • UA 16+ • 2h 45m"),
        ],
      ),
    );
  }

  Widget _buildShowsContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
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
            SizedBox(width: 10),
            CustomText(
              text: 'Show',
              color: OTTColors.buttoncolour,
              fontFamily: 'DM Sans',
             fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            Spacer(),
             CustomText(
              text: '1 Result Found',
              color: OTTColors.preferredServices,
              fontStyle: FontStyle.italic,
              fontFamily: 'DM Sans',
             fontWeight: FontWeight.w400,
              fontSize: 16,
              
            ),
          ],
        ),
          const SizedBox(height: 16),
          _buildShowCard("Di Bekaraar", "Hindi, Tamil, Telegu", "2021 • UA 16+ • 2 Seasons"),
        ],
      ),
    );
  }

  Widget _buildPeopleContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
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
            SizedBox(width: 10),
            CustomText(
              text: 'People',
              color: OTTColors.buttoncolour,
              fontFamily: 'DM Sans',
             fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            Spacer(),
             CustomText(
              text: '1 Result Found',
              color: OTTColors.preferredServices,
              fontStyle: FontStyle.italic,
              fontFamily: 'DM Sans',
             fontWeight: FontWeight.w400,
              fontSize: 16,
              
            ),
          ],
        ),
          const SizedBox(height: 16),
          _buildPeopleCard("Diljit Dosanjh", "Actor, Singer", '"I Result Found"'),
        ],
      ),
    );
  }

  Widget _buildMovieCard(String title, String language, String details) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Image.asset('assets/movie.png',height: Get.height *0.15,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Language: $language",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShowCard(String title, String language, String details) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
            Image.asset('assets/show.png',height: Get.height *0.15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Language: $language",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // see people in tab view
  Widget _buildPeopleCard(String name, String profession, String quote) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Image.asset('assets/people.png',height: Get.height *0.15,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                 text: name,
                 color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'DM Sans',
                ),
                const SizedBox(height: 2),
                CustomText(
                 text: profession,
                color: OTTColors.preferredServices,
                    fontSize: 13,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500,

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}