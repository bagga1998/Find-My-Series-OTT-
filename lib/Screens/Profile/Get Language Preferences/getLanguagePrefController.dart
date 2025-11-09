// ignore_for_file: use_build_context_synchronously, deprecated_member_use, avoid_print

import 'dart:ui';
import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/Screens/Profile/Get%20Language%20Preferences/getLanguagePrefModel.dart';
import 'package:find_my_series/auth/Login%20with%20email/loginScreen.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Getlanguageprefcontroller extends GetxController {
  var isLoading = true.obs;
  var getSavedLanguageList = [].obs;
  var selectedLanguages = <String>[].obs;
  var httpClient = http.Client();

  /// ✅ Fetch saved preferred languages
  Future<void> getSavedPreferredLanguagesFunction(BuildContext context) async {
    print("Get preferred saved language function calling...");
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isEmpty) {
      Get.off(() => const Loginscreen());
      return;
    }

    try {
      isLoading.value = true;
      final url = Uri.parse(ApiConstants.getSavedPreferredLanguage);
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(url, headers: headers);
      print("🌐 API URL: $url");
      print("📦 Response Body: ${response.body}");
      print("🔑 Token: $token");

      if (response.statusCode == 200) {
        final modelResponse = getLanguagePrefModelFromJson(response.body);
        getSavedLanguageList.assignAll(modelResponse.data);
      } else {
        _showModernMessage(context, 'Failed to fetch languages', Colors.redAccent);
      }
    } catch (e) {
      _showModernMessage(context, 'Error fetching data', Colors.redAccent);
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ For optional language selection (if user wants to toggle later)
  void toggleLanguage(String name) {
    if (selectedLanguages.contains(name)) {
      selectedLanguages.remove(name);
    } else {
      selectedLanguages.add(name);
    }
  }

  /// ✅ Modern Snackbar UI
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
      actions: const [SizedBox.shrink()],
    );

    ScaffoldMessenger.of(context).showMaterialBanner(banner);
    Future.delayed(const Duration(seconds: 3), () {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    });
  }
}
