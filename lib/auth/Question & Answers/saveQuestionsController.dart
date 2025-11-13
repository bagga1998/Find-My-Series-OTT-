import 'dart:convert';
import 'dart:ui';
import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SurveyController extends GetxController {
  var isLoading = false.obs;

  Future<bool> submitAnswers(
      BuildContext context, Map<int, String> selectedAnswers) async {
    if (selectedAnswers.isEmpty) {
      _showModernMessage(
        context,
        "Please select at least one answer before submitting.",
        Colors.redAccent,
      );
      return false;
    }

    isLoading.value = true;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      print("Token in survey controller:- $token");

      if (token == null || token.isEmpty) {
        _showModernMessage(
            context, "Authentication token not found.", Colors.redAccent);
        return false;
      }

      // 🔹 Prepare request body
      List<Map<String, dynamic>> answers = [];
      selectedAnswers.forEach((key, value) {
        answers.add({
          'question_id': key + 1, // adjust according to your backend
          'selected_option_id': int.tryParse(value) ?? 0,
        });
      });

      var body = jsonEncode({'answers': answers});
      var url = ApiConstants.saveSurveyQuestions;
      print("Save survey questions Api URL:- $url");
      print("Request body:- $body");

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      print("Status code:- ${response.statusCode}");
      print("Response body:- ${response.body}");

      switch (response.statusCode) {
        case 200:
        case 201:
          _showModernMessage(
              context, "Answers submitted successfully.", Colors.greenAccent);
          return true;

        case 400:
          _showModernMessage(
              context, "Bad Request: ${response.body}", Colors.redAccent);
          return false;

        case 401:
          _showModernMessage(
              context, "Unauthorized: Invalid token.", Colors.redAccent);
          return false;

        case 403:
          _showModernMessage(
              context, "Forbidden: Access denied.", Colors.redAccent);
          return false;

        case 404:
          _showModernMessage(
              context, "API endpoint not found.", Colors.orangeAccent);
          return false;

        case 500:
          _showModernMessage(
              context, "Server error: Please try again later.", Colors.redAccent);
          return false;

        default:
          _showModernMessage(
              context, "Unexpected error: ${response.body}", Colors.redAccent);
          return false;
      }
    } catch (e) {
      _showModernMessage(context, e.toString(), Colors.redAccent);
      return false;
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

    Future.delayed(const Duration(seconds: 3), () {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    });
  }
}
