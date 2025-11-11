import 'package:find_my_series/Screens/Movie%20details%20screen/movieDetailsScreen.dart';
import 'package:find_my_series/Screens/Popular%20Indian%20Movies/popularIndianMoviesController.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PopularIndianMoviesScreen extends StatefulWidget {
  const PopularIndianMoviesScreen({super.key});

  @override
  State<PopularIndianMoviesScreen> createState() =>
      _PopularIndianMoviesScreenState();
}

class _PopularIndianMoviesScreenState extends State<PopularIndianMoviesScreen> {
  final PopularIndianMoviescontroller objPopularIndianMoviescontroller =
      Get.put(PopularIndianMoviescontroller());

  final TextEditingController _searchController = TextEditingController();
  String searchText = '';

  @override
  void initState() {
    super.initState();
    objPopularIndianMoviescontroller.popularMoviesFunctions(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingText: 'BACK TO PREVIOUS PAGE',
        leadingIcon: Icons.arrow_back_ios_new_rounded,
        showBackArrow: true,
        leadingOnPressed: Get.back,
        leadingIconSize: 18,
        leadingTextStyle: const TextStyle(
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
            // 🔹 Background
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/background.svg',
                fit: BoxFit.cover,
              ),
            ),

            // 🔹 Foreground content
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Header Row
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
                        text: 'Popular Indian Movies',
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

                  // 🔹 Search Bar
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
                        hintText: 'Search By Movie Name',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),

                  // 🔹 Movie List
                  Expanded(
                    child: Obx(() {
                      if (objPopularIndianMoviescontroller.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: OTTColors.buttoncolour,
                          ),
                        );
                      }

                      final movies = objPopularIndianMoviescontroller
                          .popularMoviesList
                          .where((movie) => movie.title
                              .toLowerCase()
                              .contains(searchText.toLowerCase()))
                          .toList();

                      if (movies.isEmpty) {
                        return const Center(
                          child: Text(
                            'No movies found',
                            style: TextStyle(color: Colors.white70),
                          ),
                        );
                      }

                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
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
                                // 🔹 Movie Poster
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => MovieDetailsScreen(
                                            movieId: movie.id.toString(),
                                          ));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        movie.thumbnailUrl.isNotEmpty
                                            ? movie.thumbnailUrl
                                            : 'https://via.placeholder.com/150',
                                        height: height * 0.12,
                                        width: height * 0.10,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stack) =>
                                            Image.asset(
                                          'assets/no_image.png',
                                          height: height * 0.12,
                                          width: height * 0.10,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: width * 0.03),

                                // 🔹 Movie Details
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: height * 0.015,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          movie.title,
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
                                              text: 'Language:',
                                              color: OTTColors.preferredServices,
                                              fontSize: width * 0.040,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'DM Sans',
                                            ),
                                            Flexible(
                                              child: CustomText(
                                                text: ' ${movie.languageNames.join(", ")}',
                                                color: OTTColors.preferredServices,
                                                fontSize: width * 0.035,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'DM Sans',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: height * 0.006),
                                        Row(
                                          children: [
                                            CustomText(
                                              text:
                                                  movie.certificateId.toString(),
                                              color:
                                                  OTTColors.preferredServices,
                                              fontSize: width * 0.035,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'DM Sans',
                                            ),
                                            const SizedBox(width: 6),
                                            CustomText(
                                              text: '• ${movie.duration}',
                                              color:
                                                  OTTColors.preferredServices,
                                              fontSize: width * 0.035,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'DM Sans',
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: height * 0.006),
                                        CustomText(
                                          text: 'WATCH IT ON ${movie.country.toUpperCase()}',
                                          color: OTTColors.buttoncolour,
                                          fontSize: width * 0.040,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w600,
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
