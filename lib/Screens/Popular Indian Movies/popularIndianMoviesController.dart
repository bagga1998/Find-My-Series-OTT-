// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:ui';

import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/Screens/Popular%20Indian%20Movies/popularIndianMoviesModel.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PopularIndianMoviescontroller extends GetxController {
  var isLoading = true.obs;
  var popularMoviesList = [].obs;
  var httpClient = http.Client();

  Future<void> popularMoviesFunctions(BuildContext context) async {
    print("Popular indian movies function called...........................");
    try {
      isLoading.value = true;
      var url = Uri.parse(ApiConstants.popularIndianMovies);
      var response = await httpClient.get(url);
      final popularIndianMoviesModel = popularIndianMoviesListModelFromJson(
        response.body,
      );
      print("Popular movies status code:- ${response.statusCode}");
      print("Popular movies url:- $url");
      print("Popular movies body response:- ${response.body}");
      if (response.statusCode == 200) {
        popularMoviesList.addAll(popularIndianMoviesModel.movies);
        isLoading.value = false;
      } else {
        _showModernMessage(
          context,
          'Faild to fetch popular indian movies data. Try again',
          Colors.redAccent,
        );
        isLoading.value = false;
      }
      if (response.statusCode == 500) {
        _showModernMessage(context, 'Internal Server Error', Colors.redAccent);
        isLoading.value = false;
      }
      if (response.statusCode == 409) {
        _showModernMessage(
          context,
          'Duplicate entry - value must be unique',
          Colors.redAccent,
        );
        isLoading.value = false;
      }

      if (response.statusCode == 400) {
        _showModernMessage(context, 'Validation Error', Colors.redAccent);
        isLoading.value = false;
      }
    } catch (error) {
      isLoading.value = false;
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

    // 🔹 Automatically dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    });
  }


}
