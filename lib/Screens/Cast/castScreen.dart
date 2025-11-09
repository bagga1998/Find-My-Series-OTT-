import 'package:find_my_series/Screens/Celebrity%20Details/celebrityDetails.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CastScreen extends StatefulWidget {
  const CastScreen({super.key});

  @override
  State<CastScreen> createState() => _CastScreenState();
}

class _CastScreenState extends State<CastScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';

  final List<Map<String, String>> castList = [
    {
      'name': 'Rukmini Vasanth',
      'character': 'Kanakavathi',
      'image': 'assets/celebrities.png',
    },
    {
      'name': 'Rishab Shetty',
      'character': 'Berme',
      'image': 'assets/celebrities.png',
    },
    {
      'name': 'Gulshan Devaiah',
      'character': 'Kulashakara',
      'image': 'assets/celebrities.png',
    },
    {
      'name': 'Rakesh Poojari',
      'character': 'Peppe',
      'image': 'assets/celebrities.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final filteredCast = castList
        .where(
          (c) => c['name']!.toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingText: 'BACK TO PREVIOUS PAGE',
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
      body: SafeArea(
        child: Stack(
          children: [
            // Background
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/background.svg',
                fit: BoxFit.cover,
              ),
            ),

            // Foreground content
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  // Header
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
                        text: 'Cast',
                        color: OTTColors.buttoncolour,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      Spacer(),
                      const Icon(
                        Icons.filter_list,
                        color: OTTColors.buttoncolour,
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),

                  // Search Bar
                  Container(
                    height: height * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) => setState(() => searchText = val),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white70,
                        ),
                        hintText: 'Search By Name',
                        hintStyle: const TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),

                  // Cast List
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredCast.length,
                      itemBuilder: (context, index) {
                        final actor = filteredCast[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: height * 0.015),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Actor Image - slightly overlapping & larger
                              Transform.translate(
                                offset: Offset(-width * 0.015, 0),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      12,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(CelebrityDetails(celebrityId: '2',));
                                      },
                                      child: Image.asset(
                                        actor['image'] ??
                                            'assets/celebrities.png',
                                        height: height * 0.12,
                                        width: height * 0.10,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: width * 0.03),

                              // Actor details
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: height * 0.015,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        actor['name'] ?? '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.045,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'DM Sans',
                                        ),
                                      ),
                                      SizedBox(height: height * 0.003),
                                      Text(
                                        actor['character'] ?? '',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: width * 0.037,
                                          fontFamily: 'DM Sans',
                                        ),
                                      ),
                                      SizedBox(height: height * 0.006),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.favorite_border,
                                            color: Colors.white70,
                                            size: 18,
                                          ),
                                          SizedBox(width: width * 0.015),
                                          CustomText(
                                            text: 'Add to Favorites',
                                            color: Colors.white70,
                                            fontSize: width * 0.034,
                                            fontFamily: 'DM Sans',
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
          ],
        ),
      ),
    );
  }
}
