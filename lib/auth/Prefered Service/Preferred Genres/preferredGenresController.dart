import 'dart:ui';

import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/auth/Prefered%20Service/Preferred%20Genres/preferredGenresModel.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class PreferredGenrescontroller extends GetxController {
  var isLoading = true.obs;
  var preferredGenresList = [].obs;
  var selectedGenres = <String>[].obs;
  

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