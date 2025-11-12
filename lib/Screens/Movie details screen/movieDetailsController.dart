// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:ui';
import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/Screens/Movie%20details%20screen/movieDetailsModel.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetMovieDetailsController extends GetxController {
  var isLoading = false.obs;

  // ✅ Reactive fields (from API response)
  var title = ''.obs;
  var description = ''.obs;
  var releaseDate = ''.obs;
  var year = ''.obs;
  var duration = ''.obs;
  var country = ''.obs;
  var rating = ''.obs;
  var views = ''.obs;
  var videoUrl = ''.obs;
  var type = ''.obs;
  var thumbnailUrl = ''.obs;
  var trailerUrl = ''.obs;
  var platformName = ''.obs;
  var certificateName = ''.obs;
  var statusName = ''.obs;
  var summary = ''.obs;

  // ✅ Lists
  var genreNames = <String>[].obs;
  var languageNames = <String>[].obs;
  var reviews = [].obs;

  final http.Client httpClient = http.Client();

  /// ✅ Fetch Movie Details API
  Future<void> getMovieDetails(BuildContext context, String id) async {
    print('🎬 Fetching movie details for ID: $id ...');

    try {
      isLoading.value = true;

      final url = Uri.parse('${ApiConstants.popularIndianMovies}/$id');
      print("📡 API URL: $url");

      final response = await httpClient.get(url);
      print("🧾 Response Code: ${response.statusCode}");
      print("🧠 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final model = popularIndianMoviesDetailsModelFromJson(response.body);

        // ✅ Update movie details safely
        title.value = model.movie.title;
        description.value = model.movie.description ;
        releaseDate.value = model.movie.releaseDate.toString();
        year.value = model.movie.year.toString();
        duration.value = model.movie.duration.trim();
        country.value = model.movie.country.trim();
        rating.value = model.movie.rating;
        views.value = model.movie.views;
        videoUrl.value = model.movie.videoUrl;
        type.value = model.movie.type.trim();
        thumbnailUrl.value = model.movie.thumbnailUrl;
        trailerUrl.value = model.movie.trailerUrl;
        platformName.value = model.movie.platformName;
        certificateName.value = model.movie.certificateName;
        statusName.value = model.movie.statusName;
        summary.value = model.summary;

        // ✅ Assign genres, languages & reviews
        genreNames.assignAll(model.movie.genreNames);
        languageNames.assignAll(model.movie.languageNames);
        reviews.assignAll(model.reviews);

        print('✅ Movie fetched successfully: ${title.value}');
      } else {
        _showModernMessage(
          context,
          'Failed to fetch movie details. Please try again.',
          Colors.redAccent,
        );
      }
    } catch (error) {
      print('❌ Error fetching movie details: $error');
      _showModernMessage(
        context,
        'Error fetching movie details.',
        Colors.redAccent,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Glassmorphic-style message banner
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
