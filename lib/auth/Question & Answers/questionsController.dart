// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print

import 'dart:ui';

import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/auth/Question%20&%20Answers/questionsModel.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class QuesController extends GetxController {
  var isLoading = true.obs;
  var questionsList = [].obs;  

  Future<void> fetchQuestions(BuildContext context) async {
    try {
      isLoading.value = true;
      var url = Uri.parse(ApiConstants.getQuestions);
      final response = await http.get(url);
      print("response of preferred questions: $response");
      final modelResponse = questionsModelFromJson(response.body);

      if(response.statusCode == 200){
        questionsList.addAll(modelResponse.questions);
        
        print('questions list:- $questionsList');
        print('questions list length:- ${questionsList.length}');
        isLoading.value = false;
      } else {
        print('Failed to load questions. Status code: ${response.statusCode}');
        _showModernMessage(context, 'Faild to fetch questions', Colors.redAccent);
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
      print("catch error fetching preferred questions: $e");
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