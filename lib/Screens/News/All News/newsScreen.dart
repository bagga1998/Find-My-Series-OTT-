import 'dart:ui';
import 'package:find_my_series/Screens/News/All%20News/allNewsController.dart';
import 'package:find_my_series/Screens/News/News%20Details/newsDetailsScreen.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final Allnewscontroller allNewsController = Get.put(Allnewscontroller());

  @override
  void initState() {
    super.initState();
    allNewsController.allNews(context);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: OTTColors.black1,
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
          /// 🔹 Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 News Content
          Obx(() {
            if (allNewsController.isLoading.value) {
              /// 🔸 Show shimmer while loading
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return _buildShimmerCard();
                },
              );
            }

            if (allNewsController.newslist.isEmpty) {
              return const Center(
                child: Text(
                  'No news available',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              );
            }

            /// 🔹 Display News List
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: allNewsController.newslist.length,
              itemBuilder: (context, index) {
                final newsItem = allNewsController.newslist[index];

                return GestureDetector(
                  onTap: () {
                    Get.to(NewsDetailsScreen(newsid: newsItem.id.toString(),));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: newsItem.image != null &&
                                    newsItem.image.toString().isNotEmpty
                                ? Image.network(
                                    newsItem.image,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stack) =>
                                        Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey[800],
                                      child: const Icon(Icons.image_not_supported,
                                          color: Colors.white54),
                                    ),
                                  )
                                : Container(
                                    width: 60,
                                    height: 60,
                                    color: Colors.grey[800],
                                    child: const Icon(Icons.image_not_supported,
                                        color: Colors.white54),
                                  ),
                          ),
                          title: CustomText(
                            text: newsItem.title ?? 'Untitled',
                            color: OTTColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: "DM Sans",
                            fontSize: 17,
                          ),
                          subtitle: CustomText(
                            text: newsItem.description ?? '',
                            color: OTTColors.preferredServices,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  /// 🔹 Shimmer Card Loader
  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          title: Container(
            height: 14,
            width: 100,
            color: Colors.grey[700],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Container(
                height: 10,
                width: double.infinity,
                color: Colors.grey[700],
              ),
              const SizedBox(height: 4),
              Container(
                height: 10,
                width: Get.width * 0.6,
                color: Colors.grey[700],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
