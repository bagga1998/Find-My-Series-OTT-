// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ui';
import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/Controller/Add%20To%20Favourite/addToFavouriteModel.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddToFavouriteController extends GetxController {
  var isLoading = false.obs;
  final http.Client httpClient = http.Client();

  Future<void> addToFavouriteFunction(int movieId,BuildContext context) async {
    try {
      isLoading.value = true;

      // 🔹 Get stored token
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        print("Token not found in SharedPreferences");
        isLoading.value = false;
        return;
      }

      final Uri url = Uri.parse(ApiConstants.addToFavourite);
      print("Add to Favourite URL: $url");

      final Map<String, dynamic> body = {"movieId": movieId};

      final response = await httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      final AddToFavourite = addToFavouriteModelFromJson(response.body);

      print("🟢 Response status: ${response.statusCode}");
      print("🟣 Response body: ${response.body}");



      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ ${AddToFavourite.message}");
        print("✅ ${AddToFavourite.data}");
        print("✅ ${AddToFavourite.success}");
        _showModernMessage(context,AddToFavourite.message, Colors.redAccent);
        

      } else {
        print("Failed to add favourites.");
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
      print("Error adding to favourites: $error");
      isLoading.value = false;
    } finally {
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
