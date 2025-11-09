// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:ui';
import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/Screens/Popular%20Celebrities/popularCelebritiesModel.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Popularcelebritiescontroller extends GetxController {
  var isLoading = true.obs;
  var popularCelebritiesList = [].obs;
  var httpClient = http.Client();

  Future<void> getAllPopularCelebrities(BuildContext context) async {
    print("Get popular celebrities API Calling....................");
    try {
      isLoading.value = true;
      var url = Uri.parse(ApiConstants.popularCelebrities);
      var response = await httpClient.get(url);
      print("url:- $url");
      print("response:- ${response.body}");
      print("Status code:- ${response.statusCode}");

      final responseBody = response.body;

      if (response.statusCode == 200) {
        final popularcelebritiesModel =
            getPopularCelebritiesModelFromJson(responseBody);
        popularCelebritiesList.clear();
        popularCelebritiesList.addAll(popularcelebritiesModel.data);
        isLoading.value = false;
      } else {
        isLoading.value = false;

        String errorMessage = 'Something went wrong. Please try again.';

        try {
          // Try to parse backend message
          final decoded = jsonDecode(responseBody);
          if (decoded is Map && decoded['message'] != null) {
            errorMessage = decoded['message'].toString();
          } else if (decoded is Map && decoded['error'] != null) {
            errorMessage = decoded['error'].toString();
          }
        } catch (e) {
          // If not JSON, use response body as fallback
          errorMessage = responseBody;
        }

        // Handle known status codes
        switch (response.statusCode) {
          case 400:
            _showModernMessage(context, 'Validation Error: $errorMessage', Colors.orangeAccent);
            break;
          case 401:
            _showModernMessage(context, 'Unauthorized: $errorMessage', Colors.redAccent);
            break;
          case 404:
            _showModernMessage(context, 'Not Found: $errorMessage', Colors.redAccent);
            break;
          case 409:
            _showModernMessage(context, 'Duplicate Entry: $errorMessage', Colors.redAccent);
            break;
          case 500:
            _showModernMessage(context, 'Internal Server Error', Colors.redAccent);
            break;
          default:
            _showModernMessage(context, errorMessage, Colors.redAccent);
        }
      }
    } catch (error) {
      isLoading.value = false;
      _showModernMessage(context, "Error: $error", Colors.redAccent);
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
      // 👇 added to fix MaterialBanner assertion
      actions: [
        TextButton(
          onPressed: () =>
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
          child: const Text(
            'DISMISS',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );

    ScaffoldMessenger.of(context).showMaterialBanner(banner);

    // Auto hide after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    });
  }
}
