import 'dart:convert';
import 'dart:ui';
import 'package:find_my_series/API%20Services/baseURL&apiendPoint.dart';
import 'package:find_my_series/auth/Login%20with%20email/loginModel.dart';
import 'package:find_my_series/auth/Prefered%20Service/Preferred%20Services/preferedServices.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Logincontroller extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;
  

  Future<void> loginCOntroller(BuildContext context) async {
     final prefs = await SharedPreferences.getInstance();
   
    try {
      isLoading.value = true;

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
        _showModernMessage(
          context,
          "Please enter a valid email address.",
          Colors.redAccent,
        );
        isLoading.value = false;
        return;
      }
      if (password.isEmpty) {
        _showModernMessage(
          context,
          "Please enter your password.",
          Colors.redAccent,
        );
        isLoading.value = false;
        return;
      }

      var uri = Uri.parse(ApiConstants.login);

      final body = jsonEncode({"email": email, "password": password});

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      print("Login API Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = loginModelFromJson(response.body);
        final token = data.data.token;
        final name = data.data.user.name;
        print("token:- $token");
        print('name:- $name');

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('name', name);

        final savedtoken = prefs.getString('token');
        print('Saved Token: $savedtoken');
        print('get name:- ${prefs.getString('name')}');

        _showModernMessage(
          context,
          "Login successful!",
          OTTColors.buttoncolour,
        );
        
      prefs.setBool('is_logged_in',true);
        Get.off(const Preferedservices1());
        emailController.clear();
        passwordController.clear();
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
      if (response.statusCode == 403) {
        _showModernMessage(context, 'Email not verified. Please verify your email before logging in.', Colors.redAccent);
        isLoading.value = false;
      } 

      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
    }
  }

  void _showModernMessage(BuildContext context, String message, Color color) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentMaterialBanner();

    final banner = MaterialBanner(
      backgroundColor: Colors.transparent,
      elevation: 0,
      dividerColor: Colors.transparent,
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
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                    ),
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

    Future.delayed(const Duration(seconds: 3), () {
      // Ensure the messenger is still mounted before hiding
      if (messenger.mounted) messenger.hideCurrentMaterialBanner();
    });
  }
}
