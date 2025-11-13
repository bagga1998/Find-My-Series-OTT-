// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ui';
import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/Controller/Add%20To%20Favourite/addToFavouriteModel.dart';
import 'package:find_my_series/auth/Login%20with%20email/loginScreen.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddToFavouriteController extends GetxController {
  var isLoading = false.obs;
  final http.Client httpClient = http.Client();
  var favouriteMap = <int, bool>{}.obs; // celebrityId -> isFavourite


  Future<void> addToFavouriteFunction(int movieId, BuildContext context) async {
    try {
      isLoading.value = true;

      // 🔹 Get stored token
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null || token.isEmpty) {
        print("Token not found in SharedPreferences");
        Get.off(const Loginscreen());
        isLoading.value = false;
        return;
      }

      final Uri url = Uri.parse(ApiConstants.addToFavourite);
      print("Add to Favourite URL: $url");

      final Map<String, dynamic> body = {"celebrityId": movieId};

      final response = await httpClient.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      print("🟢 Response status: ${response.statusCode}");
      print("🟣 Response body: ${response.body}");

      // ✅ Check if body is non-empty and valid JSON before parsing
     if (response.body.isNotEmpty) {
  final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

  // ✅ Safely handle missing 'data' field
  if (!jsonResponse.containsKey('data') || jsonResponse['data'] == null) {
    // The server did not send data (like in 400 response)
    final message = jsonResponse['message'] ?? 'Unknown error';
    _showModernMessage(context, message, Colors.redAccent);
    print('⚠️ Server message: $message');
    isLoading.value = false;
    return;
  }

  // ✅ Only create model when valid data is present
  final AddToFavourite = AddToFavouriteModel.fromJson(jsonResponse);

  if (response.statusCode == 200 || response.statusCode == 201) {
    print("✅ ${AddToFavourite.message}");
    _showModernMessage(context, AddToFavourite.message, Colors.greenAccent);
  } else {
    _showModernMessage(context, AddToFavourite.message, Colors.redAccent);
  }
}
 else {
        print("⚠️ Empty response body received from server.");
        _showModernMessage(
          context,
          "No response from server.",
          Colors.redAccent,
        );
      }

      if (response.statusCode == 500) {
        _showModernMessage(context, 'Internal Server Error', Colors.redAccent);
      } else if (response.statusCode == 409) {
        _showModernMessage(
          context,
          'Duplicate entry - value must be unique',
          Colors.redAccent,
        );
      } else if (response.statusCode == 400) {
        _showModernMessage(context, 'Validation Error', Colors.redAccent);
      }
    } catch (error) {
      print("Error adding to favourites: $error");
      _showModernMessage(
        context,
        "Something went wrong: $error",
        Colors.redAccent,
      );
    } finally {
      isLoading.value = false;
    }
  }

void _showModernMessage(BuildContext context, String message, Color color) {
  final overlay = Overlay.of(context);
  if (overlay == null) return;

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: kToolbarHeight + MediaQuery.of(context).padding.top + 8, // 👈 below AppBar
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.08),
                    Colors.white.withOpacity(0.02),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: color.withOpacity(0.6),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.notifications_active_rounded,
                      color: color, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomText(
                      text: message,
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => overlayEntry.remove(),
                    child: const Icon(Icons.close,
                        color: Colors.white70, size: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  // Insert overlay
  overlay.insert(overlayEntry);

  // Auto-dismiss after 3 seconds
  Future.delayed(const Duration(seconds: 3), () {
    if (overlayEntry.mounted) overlayEntry.remove();
  });
}
}
