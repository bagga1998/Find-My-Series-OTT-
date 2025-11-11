// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:ui';
import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddToWatchlistController extends GetxController {
  var isLoading = false.obs;
  var isAdded = false
      .obs; // ✅ New reactive variable to control button text and state
  final http.Client httpClient = http.Client();

  Future<void> addToWatchlistFunction(String movieId, BuildContext context) async {
    try {
      isLoading.value = true;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        showModernMessage(context, 'No token found. Please log in again.', Colors.redAccent);
        isLoading.value = false;
        return;
      }

      final Uri url = Uri.parse(ApiConstants.addtowatchlist);
      print("🎬 Add to Watchlist URL: $url");

      final Map<String, dynamic> body = {
        "movieId": int.parse(movieId),
        "status": "watching",
      };

      final response = await httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      print("🟢 Status Code: ${response.statusCode}");
      print("🟣 Raw Response: ${response.body}");

      dynamic decodedResponse;
      try {
        decodedResponse = jsonDecode(response.body);
      } catch (_) {
        decodedResponse = {};
      }

      final String message = decodedResponse?['message']?.toString() ?? 'No message from server';
      final bool success = decodedResponse?['success'] == true;

      if (success) {
        isAdded.value = true; // ✅ Update UI to show “Added”
      }

      // ✅ Always show API message clearly
      switch (response.statusCode) {
        case 200:
        case 201:
          showModernMessage(context, message, Colors.greenAccent);
          break;
        case 400:
          showModernMessage(context, message, Colors.orangeAccent);
          break;
        case 401:
          showModernMessage(context, "Unauthorized. Please log in again.", Colors.redAccent);
          break;
        case 403:
          showModernMessage(context, "Access Denied: $message", Colors.deepOrangeAccent);
          break;
        case 404:
          showModernMessage(context, "Endpoint Not Found: $message", Colors.grey);
          break;
        case 409:
          showModernMessage(context, message, Colors.purpleAccent);
          break;
        case 500:
          showModernMessage(context, "Server Error: $message", Colors.redAccent);
          break;
        default:
          showModernMessage(context, "Unexpected Error (${response.statusCode}): $message", Colors.blueGrey);
      }
    } catch (error) {
      print("❌ Error adding to watchlist: $error");
      showModernMessage(context, "Something went wrong. Please try again.", Colors.redAccent);
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Glass-style message banner with safe dismiss
  void showModernMessage(BuildContext context, String message, Color color) {
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
          child: const Text("DISMISS", style: TextStyle(color: Colors.white70)),
        ),
      ],
    );

    ScaffoldMessenger.of(context).showMaterialBanner(banner);

    Future.delayed(const Duration(seconds: 3), () {
      if (ScaffoldMessenger.of(context).mounted) {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      }
    });
  }

}
