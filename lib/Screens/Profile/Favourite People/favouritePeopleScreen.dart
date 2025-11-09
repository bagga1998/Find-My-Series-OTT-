import 'dart:ui';
import 'package:find_my_series/Controller/Add%20to%20watch%20list/addToWatchListController.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Favouritepeoplescreen extends StatefulWidget {
  const Favouritepeoplescreen({super.key});

  @override
  State<Favouritepeoplescreen> createState() => _FavouritepeoplescreenState();
}

class _FavouritepeoplescreenState extends State<Favouritepeoplescreen> {
  final TextEditingController _searchController = TextEditingController();
  final AddToWatchlistController _favController = Get.put(AddToWatchlistController());

  String searchText = '';

  /// Mock data — replace with your API list later
  List<Map<String, dynamic>> celebrities = [
    {
      "id": "101",
      "name": "Shah Rukh Khan",
      "profession": "Actor",
      "photo": "assets/celebrities.png",
      "isFavourite": false,
    },
    {
      "id": "102",
      "name": "Deepika Padukone",
      "profession": "Actress",
      "photo": "assets/celebrities.png",
      "isFavourite": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
            icon: const Icon(Icons.more_vert, color: OTTColors.whiteColor),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            /// Background
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/background.svg',
                fit: BoxFit.cover,
              ),
            ),

            /// Foreground content
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
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
                      const SizedBox(width: 10),
                      CustomText(
                        text: 'Popular Indian Celebrities',
                        color: OTTColors.buttoncolour,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.filter_list,
                        color: OTTColors.buttoncolour,
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),

                  /// Search Bar
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
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.white70),
                        hintText: 'Search By Name',
                        hintStyle: TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),

                  /// Celebrity List
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: celebrities.length,
                      itemBuilder: (context, index) {
                        final item = celebrities[index];
                        final isFav = item["isFavourite"] == true;

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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: height * 0.12,
                                  width: height * 0.10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.asset(
                                    item["photo"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.03),
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
                                        text: item["name"],
                                        color: OTTColors.whiteColor,
                                        fontSize: width * 0.045,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'DM Sans',
                                      ),
                                      SizedBox(height: height * 0.003),
                                      CustomText(
                                        text: item["profession"],
                                        color: Colors.white70,
                                        fontSize: width * 0.037,
                                        fontFamily: 'DM Sans',
                                      ),
                                      SizedBox(height: height * 0.006),
                                      GestureDetector(
                                        onTap: () async {
                                          /// Disable UI toggle until API success
                                          await _favController.addToWatchlistFunction(
                                            item["id"].toString(),
                                            context,
                                          );

                                          /// After successful API response (200/201)
                                          setState(() {
                                            item["isFavourite"] = true;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              isFav
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: isFav
                                                  ? Colors.redAccent
                                                  : Colors.white70,
                                              size: 18,
                                            ),
                                            SizedBox(width: width * 0.015),
                                            CustomText(
                                              text: isFav
                                                  ? 'Added to Favorites'
                                                  : 'Add to Favorites',
                                              color: Colors.white70,
                                              fontSize: width * 0.034,
                                              fontFamily: 'DM Sans',
                                            ),
                                          ],
                                        ),
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
