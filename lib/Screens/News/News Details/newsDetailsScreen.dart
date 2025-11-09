import 'dart:ui';
import 'package:find_my_series/Screens/News/News%20Details/newsDetailsController.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String newsid;
  const NewsDetailsScreen({super.key, required this.newsid});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final NewsDetailsController objNewsDetailsController = Get.put(
    NewsDetailsController(),
  );

  @override
  void initState() {
    super.initState();
    objNewsDetailsController.getNewsDetails(context, widget.newsid);
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share_outlined, color: OTTColors.whiteColor),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background SVG Image
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),

          // Scrollable content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              if (objNewsDetailsController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: OTTColors.preferredServices,
                  ),
                );
              }

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Glassmorphic news card
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              // Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: SizedBox(
                                  width: double.infinity,
                                  height:
                                      height *
                                      0.3, // You can adjust height ratio (0.3 = 30% of screen height)
                                  child:
                                      objNewsDetailsController
                                          .image
                                          .value
                                          .isNotEmpty
                                      ? Image.network(
                                          objNewsDetailsController.image.value,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: SizedBox(
                                                height: 40,
                                                width: 40,
                                                child: CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                        Color
                                                      >(
                                                        OTTColors
                                                            .preferredServices,
                                                      ),
                                                  value:
                                                      loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            (loadingProgress
                                                                    .expectedTotalBytes ??
                                                                1)
                                                      : null,
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Container(
                                                  color: Colors.black26,
                                                  child: Center(
                                                    child: CustomText(
                                                      text: 'No Image Found',
                                                      color:
                                                          OTTColors.whiteColor,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                );
                                              },
                                        )
                                      : Image.asset(
                                          'assets/latestNews.png',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),

                              // Date
                              CustomText(
                                text:
                                    "Updated on ${objNewsDetailsController.date.value.isNotEmpty ? objNewsDetailsController.date.value : 'N/A'}",
                                color: OTTColors.preferredServices,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'DM Sans',
                              ),
                              const SizedBox(height: 12),

                              // Title
                              CustomText(
                                text:
                                    objNewsDetailsController
                                        .title
                                        .value
                                        .isNotEmpty
                                    ? objNewsDetailsController.title.value
                                    : "No title available",
                                color: OTTColors.whiteColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'DM Sans',
                              ),
                              const SizedBox(height: 8),

                              // Description
                              CustomText(
                                text:
                                    objNewsDetailsController
                                        .description
                                        .value
                                        .isNotEmpty
                                    ? objNewsDetailsController.description.value
                                    : "No description available",
                                color: Colors.white70,
                                fontSize: 14,
                                fontFamily: 'DM Sans',
                              ),
                              const SizedBox(height: 12),

                              // Platform (Static for now, you can map from API if added)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomText(
                                    text: "Platform: ",
                                    color: OTTColors.whiteColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'DM Sans',
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: CustomText(
                                      text: "Find My Series",
                                      color: OTTColors.preferredServices,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'DM Sans',
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Genres
                              Row(
                                children: [
                                  const CustomText(
                                    text: "Genre: ",
                                    color: OTTColors.whiteColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'DM Sans',
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: CustomText(
                                      text:
                                          objNewsDetailsController
                                              .genresList
                                              .isNotEmpty
                                          ? objNewsDetailsController.genresList
                                                .join(', ')
                                          : "N/A",
                                      color: OTTColors.preferredServices,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'DM Sans',
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Languages
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomText(
                                    text: "Language: ",
                                    color: OTTColors.whiteColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'DM Sans',
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: CustomText(
                                      text:
                                          objNewsDetailsController
                                              .languageList
                                              .isNotEmpty
                                          ? objNewsDetailsController
                                                .languageList
                                                .join(', ')
                                          : "N/A",
                                      color: OTTColors.preferredServices,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'DM Sans',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
