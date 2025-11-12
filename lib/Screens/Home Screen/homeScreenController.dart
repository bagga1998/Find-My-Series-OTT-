// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:ui';
import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/Screens/Home%20Screen/homeScreenModel.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController {
  final http.Client httpClient = http.Client();

  // Loading indicator
  var isLoading = false.obs;

  // Data lists
  var topBannersList = [].obs;
  var popularIndianMoviesList = [].obs;
  var popularIndianTvShowsList = [].obs;
  var popularCelebritiesList = [].obs;
  var releasedTodayList = [].obs;
  var bornTodayList = [].obs;
  var nowStreamingList = [].obs;
  var comingSoonList = [].obs;

  /// Fetch all homepage data
  Future<void> fetchHomePageData(BuildContext context) async {
    try {
      isLoading.value = true;

      final url = Uri.parse(ApiConstants.homepage);
      final response = await httpClient.get(url);

      if (response.statusCode == 200) {
        final parsedData = homePageModelFromJson(response.body);

        if (parsedData.success) {
          // ✅ Clear old data before adding new
          topBannersList.clear();
          popularIndianMoviesList.clear();
          popularIndianTvShowsList.clear();
          popularCelebritiesList.clear();
          releasedTodayList.clear();
          bornTodayList.clear();
          nowStreamingList.clear();
          comingSoonList.clear();

          // ✅ Assign new data
          topBannersList.addAll(parsedData.data.topBanners);
          popularIndianMoviesList.addAll(parsedData.data.popularIndianMovies);
          popularIndianTvShowsList.addAll(parsedData.data.popularIndianTvShows);
          popularCelebritiesList.addAll(parsedData.data.popularCelebrities);
          releasedTodayList.addAll(parsedData.data.releasedToday);
          bornTodayList.addAll(parsedData.data.bornToday);
          nowStreamingList.addAll(parsedData.data.nowStreaming);
          comingSoonList.addAll(parsedData.data.comingSoon);

          isLoading.value = false;
        } else {
          _showModernMessage(context, parsedData.message, Colors.orangeAccent);
          isLoading.value = false;
        }
      } else if (response.statusCode == 400) {
        _showModernMessage(context, 'Validation Error', Colors.redAccent);
        isLoading.value = false;
      } else if (response.statusCode == 409) {
        _showModernMessage(context, 'Duplicate entry - value must be unique', Colors.redAccent);
        isLoading.value = false;
      } else if (response.statusCode == 500) {
        _showModernMessage(context, 'Internal Server Error', Colors.redAccent);
        isLoading.value = false;
      } else {
        _showModernMessage(context, 'Failed to fetch homepage data. Try again.', Colors.redAccent);
        isLoading.value = false;
      }
    } catch (error) {
      print('Error fetching home data: $error');
      isLoading.value = false;
      _showModernMessage(context, 'Something went wrong. Please try again.', Colors.redAccent);
    }
  }

  /// Modern Snackbar-style banner
  void _showModernMessage(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

    final banner = MaterialBanner(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              border: Border.all(color: color.withOpacity(0.6), width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.notifications_active_rounded, color: color),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomText(
                    text: message,
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: const [],
    );

    ScaffoldMessenger.of(context).showMaterialBanner(banner);

    Future.delayed(const Duration(seconds: 3), () {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    });
  }
}
