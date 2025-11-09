// ignore_for_file: unnecessary_string_interpolations

import 'package:find_my_series/Screens/Popular%20Indian%20Movies/popularIndianMoviesController.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/dropdown.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Ratinghistoryscreen extends StatefulWidget {
  const Ratinghistoryscreen({super.key});

  @override
  State<Ratinghistoryscreen> createState() => _RatinghistoryscreenState();
}

class _RatinghistoryscreenState extends State<Ratinghistoryscreen> {
  final PopularIndianMoviescontroller objPopularIndianMoviescontroller =
      Get.put(PopularIndianMoviescontroller());
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    objPopularIndianMoviescontroller.popularMoviesFunctions(context);
  }

  String? selectedgenre;
  final List<String> genresItems = [
    'All',
    'Action',
    'Comedy',
    'Drama',
    'Thriller',
  ];

  String? selecteLanguage;
  final List<String> languagelist = [
    'All',
    'Action',
    'Comedy',
    'Drama',
    'Thriller',
  ];

  final List<Map<String, String>> genreslist = [
    {
      'name': 'War 2',
      'character': 'Language: Hindi',
      'image': 'assets/cs1.png',
    },
    {
      'name': 'Hello Mini 3',
      'character': 'Language: Hindi',
      'image': 'assets/topPick1.png',
    },
    {
      'name': 'Kesari 2',
      'character': 'Language: Hindi',
      'image': 'assets/thriller.png',
    },
    {
      'name': 'Hichki',
      'character': 'Language: Hindi',
      'image': 'assets/topPick2.png',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final filteredCast = genreslist
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
                      Row(
                        children: [
                          CustomText(
                            text: 'Rating History ',
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
                        hintText: 'Search By Movie and TV Show Name',
                        hintStyle: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    children: [
                      _genresDropdown(width, height),
                      SizedBox(width: width * 0.05),
                      _languageDropdown(width, height),
                    ],
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
                                  child: GestureDetector(
                                    onTap: () {
                                      // Get.to(MovieDetailsScreen(movieId: '1',));  //////////////////////////////////////  chnage here and send the dynamic celebrity ID here
                                    },
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(12),
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
                                      CustomText(
                                        text: actor['name'] ?? '',
                                        color: OTTColors.whiteColor,
                                        fontSize: width * 0.045,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'DM Sans',
                                      ),
                                      SizedBox(height: height * 0.003),
                                      Row(
                                        children: [
                                          CustomText(
                                            text:
                                                "Added on ${DateFormat('MMM dd, yyyy').format(DateTime.now())}",
                                            color: OTTColors.preferredServices,
                                            fontSize: width * 0.040,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'DM Sans',
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: height * 0.006),
                                      // SizedBox(width: width * 0.015),
                                      // ⭐ Rated Row
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            text: 'Rated:',
                                            color: OTTColors.buttoncolour,
                                            fontSize: width * 0.038,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'DM Sans',
                                          ),
                                          SizedBox(width: width * 0.01),
                                          Icon(
                                            Icons.star_rounded,
                                            color: OTTColors.buttoncolour,
                                            size: width * 0.045,
                                          ),
                                          SizedBox(width: width * 0.005),
                                          CustomText(
                                            text: '10',
                                            color: OTTColors.buttoncolour,
                                            fontSize: width * 0.040,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: height * 0.008),

                                      // 👁 Rating + Watched Row
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star_rounded,
                                            color: OTTColors.icon,
                                            size: width * 0.045,
                                          ),
                                          SizedBox(width: width * 0.005),
                                          CustomText(
                                            text: '8.6',
                                            color: OTTColors.whiteColor,
                                            fontSize: width * 0.040,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w600,
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.remove_red_eye_rounded,
                                            color: OTTColors.buttoncolour,
                                            size: width * 0.045,
                                          ),
                                          SizedBox(width: width * 0.006),
                                          Padding(
                                            padding: const EdgeInsets.only(right:8.0),
                                            child: CustomText(
                                              text: 'Watched',
                                               color: OTTColors.buttoncolour,
                                              fontSize: width * 0.038,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'DM Sans',
                                            ),
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

  Widget _genresDropdown(double width, double height) {
    return IntrinsicWidth(
      child: CustomDropdownButton2(
        hint: const Text(
          'Genres',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        value: selectedgenre,
        dropdownItems: genresItems,
        onChanged: (value) {
          setState(() {
            selectedgenre = value;
          });
        },
        buttonHeight: height * 0.065,
        borderRadius: 16,
        buttonDecoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
        selectedItemTextColor: Colors.white,
        selectedItemFontWeight: FontWeight.w600,
        enableSearch: false,

        dropdownDecoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        itemHeight: height * 0.05,
        itemPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
      ),
    );
  }

  Widget _languageDropdown(double width, double height) {
    return IntrinsicWidth(
      child: CustomDropdownButton2(
        hint: const Text(
          'Language',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        value: selecteLanguage,
        dropdownItems: languagelist,
        onChanged: (value) {
          setState(() {
            selecteLanguage = value;
          });
        },
        buttonHeight: height * 0.065,
        borderRadius: 16,
        buttonDecoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
        selectedItemTextColor: Colors.white,
        selectedItemFontWeight: FontWeight.w600,
        enableSearch: false,

        dropdownDecoration: BoxDecoration(
          color: Colors.black.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        itemHeight: height * 0.05,
        itemPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
      ),
    );
  }


}
