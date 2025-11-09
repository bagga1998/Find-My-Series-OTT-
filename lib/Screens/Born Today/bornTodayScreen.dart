import 'package:find_my_series/Screens/Born%20Today/bornTodayController.dart';
import 'package:find_my_series/Screens/Celebrity%20Details/celebrityDetails.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BornTodayScreen extends StatefulWidget {
  const BornTodayScreen({super.key});

  @override
  State<BornTodayScreen> createState() => _BornTodayScreenState();
}

class _BornTodayScreenState extends State<BornTodayScreen> {
  final TextEditingController _searchController = TextEditingController();
  final BornTodaycontroller objBornTodaycontroller = Get.put(BornTodaycontroller());

  String searchText = '';

  @override
  void initState() {
    super.initState();
    objBornTodaycontroller.bornToodayCelebrities(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // final filteredCast = castList
    //     .where(
    //       (c) => c['name']!.toLowerCase().contains(searchText.toLowerCase()),
    //     )
    //     .toList();

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
                        text: 'Born Today',
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
                    child: Obx(() {
                      if (objBornTodaycontroller.isLoading.value) {
                        // 🔹 SHIMMER PLACEHOLDER WHILE LOADING
                        return ListView.builder(
                          itemCount: 6, // number of shimmer placeholders
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: height * 0.015),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                ),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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

                      // 🔹 When Data is Loaded
                      final filteredList = objBornTodaycontroller.bornTodayList
                          .where((celebrity) {
                            final name = (celebrity.name ?? '').toLowerCase();
                            return name.contains(searchText.toLowerCase());
                          })
                          .toList();

                      if (filteredList.isEmpty) {
                        return const Center(
                          child: Text(
                            'No celebrities found.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }

                      // 🔹 Actual List View
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final celebrity = filteredList[index];

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
                                Transform.translate(
                                  offset: Offset(-width * 0.015, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(CelebrityDetails(
                                          celebrityId:
                                              celebrity.id.toString(),
                                        ));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: celebrity.photoUrl.isNotEmpty
                                            ? Image.network(
                                                celebrity.photoUrl,
                                                height: height * 0.12,
                                                width: height * 0.10,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'assets/celebrities.png',
                                                height: height * 0.12,
                                                width: height * 0.10,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
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
                                      children: [
                                        Text(
                                          celebrity.name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.045,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'DM Sans',
                                          ),
                                        ),
                                        SizedBox(height: height * 0.003),
                                        Row(
                                          children: [
                                            CustomText(
                                              text: 'Born:',
                                              color:
                                                  OTTColors.preferredServices,
                                              fontSize: width * 0.040,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'DM Sans',
                                            ),
                                            CustomText(
                                              text:
                                                  ' ${celebrity.age ?? ''} years old',
                                              color: OTTColors.preferredServices,
                                              fontSize: width * 0.035,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'DM Sans',
                                            ),
                                          ],
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
                      );
                    }),
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
