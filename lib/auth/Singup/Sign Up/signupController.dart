// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ui';
import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/auth/Login%20with%20email/loginScreen.dart';
import 'package:find_my_series/auth/Singup/Sign%20Up/signupModel.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Signupcontroller extends GetxController {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  var isLoading = false.obs;

  Future<void> userRegisteration(BuildContext context) async {
    try {
      isLoading.value = true;

      final fullName = fullnameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final age = ageController.text.trim();
      final gender = genderController.text.trim();
      final state = stateController.text.trim();

      // ✅ Email validation
      if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
        _showModernMessage(
          context,
          "Please enter a valid email address.",
          Colors.redAccent,
        );
        isLoading.value = false;
        return;
      }

      var uri = Uri.parse(ApiConstants.register);
      debugPrint('📤 Register API Endpoint: $uri');
      debugPrint('📦 Sending Data: $fullName, $email, $password, $age, $gender, $state');

      final body = jsonEncode({
        "name": fullName,
        "email": email,
        "password": password,
        "age": age,
        "gender": gender,
        "state": state,
      });

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      debugPrint("📥 API Raw Response: ${response.body}");
      debugPrint("📊 Status Code: ${response.statusCode}");

      // ✅ Try parsing message safely
      String message = "Something went wrong.";
      try {
        final decoded = json.decode(response.body);
        message = decoded['message'] ?? message;
      } catch (_) {
        debugPrint("⚠️ Response not JSON-decoded properly.");
      }

      // ✅ Show proper status messages based on status code
      switch (response.statusCode) {
        case 200:
        case 201:
          _showModernMessage(context, message, Colors.greenAccent);
          Get.off(const Loginscreen());
          _clearControllers();
          break;

        case 400:
          _showModernMessage(context, message, Colors.orangeAccent);
          break;

        case 401:
          _showModernMessage(context, message, Colors.redAccent);
          break;

        case 403:
          _showModernMessage(context, message, Colors.deepOrangeAccent);
          break;

        case 404:
          _showModernMessage(context, "Endpoint not found: $message", Colors.blueGrey);
          break;

        case 409:
          _showModernMessage(context, message, Colors.purpleAccent);
          break;

        case 500:
          _showModernMessage(context, "Server Error: $message", Colors.redAccent);
          break;

        default:
          _showModernMessage(
              context, "Unexpected Error (${response.statusCode}): $message", Colors.grey);
      }
    } catch (error) {
      debugPrint('❌ Catch error in sign-up: $error');
      _showModernMessage(
        context,
        "Something went wrong. Please try again.",
        Colors.redAccent,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Modern glass-style message for all API responses
void _showModernMessage(BuildContext context, String message, Color color) {
  final messenger = ScaffoldMessenger.of(context);

  // Hide any existing banner
  messenger.hideCurrentMaterialBanner();

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

  messenger.showMaterialBanner(banner);

  // ✅ Forcefully remove after 3 seconds
  Future.delayed(const Duration(seconds: 3), () {
    if (messenger.mounted) {
      messenger.hideCurrentMaterialBanner();
    }
  });
}

  /// ✅ Clear all text controllers after success
  void _clearControllers() {
    fullnameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    ageController.clear();
    genderController.clear();
    stateController.clear();
  }

  @override
  void onClose() {
    fullnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    ageController.dispose();
    stateController.dispose();
    genderController.dispose();
    super.onClose();
  }
}
