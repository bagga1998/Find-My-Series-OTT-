// ignore_for_file: use_build_context_synchronously, deprecated_member_use, avoid_print

import 'dart:convert';
import 'dart:ui';

import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/auth/Prefered%20Service/Preferred%20Services/preferedServicesModel.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetAllpreferredPlatforms extends GetxController {
  var isLoading = false.obs;
  var preferredPlatformsList = [].obs;
  var selectedPlatforms = <String>[].obs;
  var selectedPlatformIds = <int>[].obs; // store selected IDs

      @override
  void onInit() {
    super.onInit();
    _loadSelectedPlatformsFromLocal();
  }

  Future<void> fetchPreferredPlatforms(BuildContext context) async {
    try {
      isLoading.value = true;
      var uri = Uri.parse(ApiConstants.preferredPlatforms);
      print("Preferred Platforms URL: $uri");
      final response = await http.get(uri);
      print("Response of Preferred Platforms: $response");

      var preferredPlatformsModel = getAllSocialMedialModelFromJson(
        response.body,
      );

      if (response.statusCode == 200) {
        preferredPlatformsList.addAll(preferredPlatformsModel.data);
        print(
          "Preferred Platforms List in status code 200: $preferredPlatformsList",
        );
        isLoading.value = false;
      } else {
        print(
          'Failed to load preferred Genres. Status code: ${response.statusCode}',
        );
        _showModernMessage(
          context,
          'Faild to fetch languages',
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
      print("Catch Error fetching preferred platforms: $error");
    }
  }

/// 🔹 Save Selected Genres to API
Future<void> saveSelectedPlatforms(BuildContext context) async {
  print("...................................................................................");
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';

  if (selectedPlatformIds.isEmpty) {
    _showModernMessage(context, 'Please select at least one platform', Colors.orangeAccent);
    return;
  }

  final url = Uri.parse(ApiConstants.savePreferredPlatforms);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final body = jsonEncode({
    "platformIds": selectedPlatformIds.toList(), // ✅ Correct key for backend
  });

  print("📤 Sending platforms token: $token");
  print("📤 Sending platforms IDs: $body");
  print('Save referred platofrms api url:- $url');

  isLoading.value = true;

  try {
    final response = await http.post(url, headers: headers, body: body);
    print("📊 Status code of Platforms: ${response.statusCode}");
    print("📥 Response body of Platforms: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["success"] == true) {
      print("✅ Platforms are saved successfully: ${data["data"]}");
      isLoading.value = false;
      _showModernMessage(context, "Platforms saved successfully!", Colors.green);
    }   else {
      print("❌ Error from API: ${data["message"]}");
      isLoading.value = false;
      _showModernMessage(context, data["message"] ?? "Something went wrong", Colors.redAccent);
    } if (response.statusCode == 500) {
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
    
   
  } catch (e) {
    print("💥 Exception in saving Platforms: $e");
    isLoading.value = false;
    _showModernMessage(context, "Something went wrong", Colors.redAccent);
  } finally {
    isLoading.value = false;
  }
}

  // Optional helper: print selected languages
  void printSelectedPlatforms() {
    print("🗣️ Selected Platforms: $selectedPlatforms");
  }
  /// 🔹 Load from SharedPreferences (local)
  Future<void> _loadSelectedPlatformsFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final storedPlatforms = prefs.getStringList('selectedPlatforms');
    final storedIds = prefs.getStringList('selectedPlatformsIds');

    if (storedPlatforms != null) {
      selectedPlatforms.assignAll(storedPlatforms);
    }
    if (storedIds != null) {
      selectedPlatformIds.assignAll(storedIds.map((id) => int.parse(id)));
    }
  }

  /// 🔹 Helper: Select/Deselect Language
void togglePlatforms(String name, int id) {
  if (selectedPlatforms.contains(name)) {
    selectedPlatforms.remove(name);
    selectedPlatformIds.remove(id);
  } else {
    selectedPlatforms.add(name);
    selectedPlatformIds.add(id);
  }
  print("🗣️ Selected platforms: $selectedPlatforms");
  print("🆔 Selected Platforms IDs: $selectedPlatformIds");
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
    actions: [
      TextButton(
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        },
        child: const Text(
          'DISMISS',
          style: TextStyle(color: Colors.white70),
        ),
      ),
    ],
  );

  ScaffoldMessenger.of(context).showMaterialBanner(banner);

  // 🔹 Automatically dismiss after 3 seconds
  Future.delayed(const Duration(seconds: 3), () {
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  });
}


}
