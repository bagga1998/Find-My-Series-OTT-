// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:ui';
import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/Screens/News/News%20Details/newsDetailsModel.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class NewsDetailsController extends GetxController {
  var isLoading = true.obs;
  var httpClient = http.Client();
  var title = "".obs;
  var description = "".obs;
  var image = "".obs;
  var date = "".obs;
  var genresList = <String>[].obs;
  var languageList = <String>[].obs;

  Future<void> getNewsDetails(BuildContext context, String id) async {
    print("Fetching news details for id $id .........................................................................");
    try {
      isLoading.value = true;
      var url = Uri.parse("${ApiConstants.getAllNews}/$id");
      final response = await httpClient.get(url);
      print("Response of news details: ${response.statusCode}");

      final modelResponse = newsDetailsModelFromJson(response.body);

      if (response.statusCode == 200 && modelResponse.data != null) {
        title.value = modelResponse.data.title ?? "";
        description.value = modelResponse.data.description ?? "";
        image.value = modelResponse.data.image ?? "";
        date.value = modelResponse.data.date.toString();
        genresList.assignAll(modelResponse.data.genres ?? []);
        languageList.assignAll(modelResponse.data.languages ?? []);
        print("title:- $title");
        isLoading.value = false;
      } else {
        _showModernMessage(context, 'Failed to fetch news details', Colors.redAccent);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print("Error fetching news details: $e");
    }
  }

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
