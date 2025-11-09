// ignore_for_file: use_build_context_synchronously, deprecated_member_use, avoid_print

import 'dart:convert';
import 'dart:ui';
import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/auth/Prefered%20Service/Preferred%20Languages/PreferredlanguagesModel.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferredlanguagescontroller extends GetxController {
  var isLoading = true.obs;
  var preferredLanguageList = [].obs;
  var selectedLanguages = <String>[].obs; // store selected names
  var selectedLanguageIds = <int>[].obs; // store selected IDs

  @override
  void onInit() {
    super.onInit();
    _loadSelectedLanguagesFromLocal();
  }

  /// 🔹 Fetch Languages from API
  Future<void> fetchPreferredLanguages(BuildContext context) async {
    try {
      isLoading.value = true;
      var url = Uri.parse(ApiConstants.preferredLanguageList);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final modelResponse = preferredLanguagesModelFromJson(response.body);
        preferredLanguageList.assignAll(modelResponse.data);
      } else {
        _showModernMessage(
          context,
          'Failed to fetch languages',
          Colors.redAccent,
        );
      }
    } catch (e) {
      _showModernMessage(context, 'Error fetching data', Colors.redAccent);
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔹 Save Selected Languages to API
 /// 🔹 Save Selected Languages to API
Future<void> saveSelectedLanguages(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';

  if (selectedLanguageIds.isEmpty) {
    print("⚠️ Please select at least one language");
    Get.snackbar("Error", "Please select at least one language");
    return;
  }

  final url = Uri.parse(ApiConstants.savePreferredLanguage);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  // 🔸 Send the numeric IDs instead of names
  final body = jsonEncode({
    "languageIds": selectedLanguageIds.toList(),
  });

  print("📤 Sending token: $token");
  print("📤 Sending language IDs: $body");

  isLoading.value = true;

  try {
    final response = await http.post(url, headers: headers, body: body);
    print("📊 Status code: ${response.statusCode}");
    print("📥 Response body: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["success"] == true) {
      print("✅ Languages saved successfully: ${data["data"]}");
      // Get.snackbar("Success", "Languages saved successfully!");
      _showModernMessage(
        Get.context!,
        "Languages saved successfully!",
        Colors.green,
      );
    } else {
      print("❌ Error from API: ${data["message"]}");
      Get.snackbar("Error", data["message"] ?? "Something went wrong");
    }
  } catch (e) {
    print("💥 Exception in saving language: $e");
    Get.snackbar("Error", "Something went wrong");
  } finally {
    isLoading.value = false;
  }
}

  // Optional helper: print selected languages
  void printSelectedLanguages() {
    print("🗣️ Selected Languages: $selectedLanguages");
  }
  /// 🔹 Load from SharedPreferences (local)
  Future<void> _loadSelectedLanguagesFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final storedLangs = prefs.getStringList('selectedLanguages');
    final storedIds = prefs.getStringList('selectedLanguageIds');

    if (storedLangs != null) {
      selectedLanguages.assignAll(storedLangs);
    }
    if (storedIds != null) {
      selectedLanguageIds.assignAll(storedIds.map(int.parse));
    }
  }

  /// 🔹 Helper: Select/Deselect Language
void toggleLanguage(String name, int id) {
  if (selectedLanguages.contains(name)) {
    selectedLanguages.remove(name);
    selectedLanguageIds.remove(id);
  } else {
    selectedLanguages.add(name);
    selectedLanguageIds.add(id);
  }
  print("🗣️ Selected Names: $selectedLanguages");
  print("🆔 Selected IDs: $selectedLanguageIds");
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
      actions: const [SizedBox.shrink()],
    );

    ScaffoldMessenger.of(context).showMaterialBanner(banner);

    Future.delayed(const Duration(seconds: 3), () {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    });
  }


}
