// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:ui';

import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/auth/Prefered%20Service/Preferred%20Genres/preferredGenresModel.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferredGenrescontroller extends GetxController {
  var isLoading = true.obs;
  var preferredGenresList = [].obs;
  var selectedGenres = <String>[].obs;
  var selectedGenresIds = <int>[].obs; // store selected IDs

    @override
  void onInit() {
    super.onInit();
    _loadSelectedGenresFromLocal();
  }
  

  Future<void> fetchPreferredGenres(BuildContext context) async {
    try {
      isLoading.value = true;
      var url = Uri.parse(ApiConstants.preferredGenresList);
      final response = await http.get(url);
      print("response of preferred Genres: $response");
      final modelResponse = preferredGenresModelFromJson(response.body);

      if(response.statusCode == 200){
        preferredGenresList.addAll(modelResponse.data);
        print('Genres list:- $preferredGenresList');
        isLoading.value = false;
      } else {
        print('Failed to load preferred Genres. Status code: ${response.statusCode}');
        _showModernMessage(context, 'Faild to fetch languages', Colors.redAccent);
        isLoading.value = false;
      }

       if (response.statusCode == 500) {
        _showModernMessage(context, 'Internal Server Error', Colors.redAccent);
         isLoading.value = false;
      } 
      if (response.statusCode == 409) {
        _showModernMessage(context, 'Duplicate entry - value must be unique', Colors.redAccent);
         isLoading.value = false;


      }
      
      if (response.statusCode == 400) {
        _showModernMessage(context, 'Validation Error', Colors.redAccent);
        isLoading.value = false;
      }


    } catch (e) {
      isLoading.value = false;
      print("catch error fetching preferred languages: $e");
    } finally {
      isLoading.value = false;
    }
  }

   /// 🔹 Save Selected Languages to API
/// 🔹 Save Selected Genres to API
Future<void> saveSelectedGenres(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';

  if (selectedGenresIds.isEmpty) {
    _showModernMessage(context, 'Please select at least one genre', Colors.orangeAccent);
    return;
  }

  final url = Uri.parse(ApiConstants.savePreferredGenres);
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  final body = jsonEncode({
    "genreIds": selectedGenresIds.toList(), // ✅ Correct key for backend
  });

  print("📤 Sending token: $token");
  print("📤 Sending Genres IDs: $body");

  isLoading.value = true;

  try {
    final response = await http.post(url, headers: headers, body: body);
    print("📊 Status code of Genres: ${response.statusCode}");
    print("📥 Response body of Genres: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data["success"] == true) {
      print("✅ Genres are saved successfully: ${data["data"]}");
      _showModernMessage(context, "Genres saved successfully!", Colors.green);
    } else {
      print("❌ Error from API: ${data["message"]}");
      _showModernMessage(context, data["message"] ?? "Something went wrong", Colors.redAccent);
    }
  } catch (e) {
    print("💥 Exception in saving Genres: $e");
    _showModernMessage(context, "Something went wrong", Colors.redAccent);
  } finally {
    isLoading.value = false;
  }
}

  // Optional helper: print selected languages
  void printSelectedGenres() {
    print("🗣️ Selected Genres: $selectedGenres");
  }
  /// 🔹 Load from SharedPreferences (local)
  Future<void> _loadSelectedGenresFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final storedLangs = prefs.getStringList('selectedLanguages');
    final storedIds = prefs.getStringList('selectedLanguageIds');

    if (storedLangs != null) {
      selectedGenres.assignAll(storedLangs);
    }
    if (storedIds != null) {
      selectedGenresIds.assignAll(storedIds.map((id) => int.parse(id)));
    }
  }

  /// 🔹 Helper: Select/Deselect Language
void toggleGenres(String name, int id) {
  if (selectedGenres.contains(name)) {
    selectedGenres.remove(name);
    selectedGenresIds.remove(id);
  } else {
    selectedGenres.add(name);
    selectedGenresIds.add(id);
  }
  print("🗣️ Selected Genre: $selectedGenres");
  print("🆔 Selected IDs: $selectedGenresIds");
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