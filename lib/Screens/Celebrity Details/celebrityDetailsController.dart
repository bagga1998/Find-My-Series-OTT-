import 'dart:ui';

import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/Screens/Celebrity%20Details/celebrityDetailsModel.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetCelebrityDetailsController extends GetxController {
  var isLoading = true.obs;
  var celebrityDetails = {}.obs;
  var httpClient = http.Client();
  
  // ✅ FIX: Don't reassign Rx variables, update their values
  var name = ''.obs;
  var dob = ''.obs;
  var rolCategory = ''.obs;
  var photoUrl = ''.obs;
  var popularityScore = ''.obs;
  var bio = ''.obs;

  Future<void> getCelebrityDetails(BuildContext context, String id) async {
    print('Fetching celebrity details for ID: $id ...');
    try {
      isLoading.value = true;
      var url = Uri.parse('${ApiConstants.celebrityDetails}/$id');
      print("Celebrity Details api URL: $url");
      var response = await httpClient.get(url);
      print(response.statusCode);
      print("API response body Celebrity Details:- ${response.body}");

      var celebrityModel = celebrityDetailsModelFromJson(response.body);

      if (response.statusCode == 200) {
        // ✅ FIX: Update the values, don't reassign the Rx variables
        name.value = celebrityModel.data.name;
        dob.value = celebrityModel.data.dob.toString();
        rolCategory.value = celebrityModel.data.roleCategory;
        photoUrl.value = celebrityModel.data.photoUrl;
        popularityScore.value = celebrityModel.data.popularityScore;
        bio.value = celebrityModel.data.bio;
        
        print('-----------------Celebrity Details--------------------');
        print("Celebrity Name: ${name.value}");
        print('celebrity DOB: ${dob.value}');
        print('celebrity Role Category: ${rolCategory.value}');
        print('celebrity Photo URL: ${photoUrl.value}');
        print('celebrity Popularity Score: ${popularityScore.value}');
        
        isLoading.value = false;
      } else {
        print(
          'Failed to fetch born today celebrities data. Status code: ${response.statusCode}',
        );
        _showModernMessage(
          context,
          'Failed to fetch celebrity details. Try again',
          Colors.redAccent,
        );
        isLoading.value = false;
      }
    } catch (error) {
      print('Error fetching celebrity details: $error');
      isLoading.value = false;
      _showModernMessage(
        context,
        'Error fetching celebrity details',
        Colors.redAccent,
      );
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