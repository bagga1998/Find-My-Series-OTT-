import 'dart:ui';
import 'package:find_my_series/Screens/Settings/Delete%20Account/deleteAccountScreen2.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/button.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountScreen extends StatefulWidget {
  final List<String> pagePath;
  const DeleteAccountScreen({
    super.key,
    this.pagePath = const [
      'Profile',
      'Settings',
      'Account',
      'Delete My Account',
    ],
  });

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final String joinedDate = DateFormat(
    'yMMMMd',
  ).format(DateTime.now().subtract(const Duration(days: 365)));
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? 'No name found';
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingText: 'BACK TO PREVIOUS PAGE',
        leadingIcon: Icons.arrow_back_ios_new_rounded,
        showBackArrow: true,
        leadingOnPressed: Get.back,
        leadingIconSize: 18,
        leadingTextStyle: TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: OTTColors.whiteColor,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF161218), Color(0xFF2B1D34)],
        ),
      ),
      body: Stack(
        children: [
          /// Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

          /// Glassmorphism Overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title Row
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: Get.height * 0.025,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB968F0),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomText(
                        text: 'Delete My Account',
                        color: OTTColors.buttoncolour,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  /// Breadcrumb Path
                  Text(
                    widget.pagePath.join(' > '),
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(color: Colors.white.withOpacity(0.2), thickness: 1),

                  const SizedBox(height: 30),

                  /// Deletion Info Section
                  CustomText(
                    text: "Deleting your account is a permanent Operation",
                    color: OTTColors.whiteColor,
                    fontFamily: 'DM Sans',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    text:
                        "Deleting your account cannot be undone, so please double check that you really want to delete this account.",
                    color: OTTColors.preferredServices,
                    fontFamily: 'DM Sans',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    // height: 1.4,
                  ),

                  const SizedBox(height: 25),
                  Divider(color: Colors.white.withOpacity(0.2), thickness: 1),
                  const SizedBox(height: 25),

                  /// Account Details
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: Get.height * 0.025,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB968F0),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomText(
                        text: "Your Account Details",
                        color: OTTColors.buttoncolour,
                        fontFamily: 'DM Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Username
                  Row(
                    children: [
                      CustomText(
                        text: "Username: ",
                        color: OTTColors.whiteColor,
                        fontFamily: 'DM Sans',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: userName ?? 'Loading...',
                        color: OTTColors.preferredServices,
                        fontFamily: 'DM Sans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Joined Date
                  Row(
                    children: [
                      CustomText(
                        text: "Joined: ",
                        color: OTTColors.whiteColor,
                        fontFamily: 'DM Sans',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        text: joinedDate,
                        color: OTTColors.preferredServices,
                        fontFamily: 'DM Sans',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  /// Request Account Deletion Button
                  Center(
                    child: CustomButton(
                      text: 'Request Account Deletion',
                      onPressed: () {
                        Get.to(const DeleteAccountScreen2());
                        Get.snackbar(
                          'Success',
                          'Your request has been sent please wait.',
                          backgroundColor: OTTColors.black1,
                          colorText: OTTColors.whiteColor,
                          snackPosition: SnackPosition.TOP,
                        );
                      },

                      gradient: LinearGradient(
                        colors: [
                          OTTColors.buttoncolour,
                          OTTColors.buttoncolour1,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
