import 'dart:io';
import 'dart:ui';
import 'package:find_my_series/widgets/button.dart';
import 'package:find_my_series/widgets/textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:find_my_series/widgets/appBar.dart'; // Your Custom AppBar
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {
  final TextEditingController _usernameController = TextEditingController();
  File? _profileImage;

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // reduce file size
      );

      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      } else {
        debugPrint('No image selected');
      }
    } catch (e) {
      // Use ScaffoldMessenger instead of Get.snackbar for safety
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to pick image. Please try again.',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black.withOpacity(0.8),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingText: "BACK TO HOMEPAGE",
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
      ),
      body: Stack(
        children: [
          /// ✅ Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),

          /// ✅ Glassmorphism Overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  // Title Row
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
                        text: 'Edit Profile',
                        color: OTTColors.buttoncolour,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Profile Image
                  GestureDetector(
                    onTap: _pickImage,
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: _profileImage != null
                              ? Image.file(_profileImage!, fit: BoxFit.cover)
                              : Image.asset(
                                  'assets/show.png', // fallback image
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Change Profile Text
                  CustomText(
                    text: "Change Profile Image",
                    color: OTTColors.buttoncolour,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "DM Sans",
                    onTap: () {
                      _pickImage();
                    },
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomText(
                      text: "Username",
                      color: OTTColors.preferredServices,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: "DM Sans",
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Username Field
                  CustomTextFormField(
                    label: 'Enter your email',
                    controller: _usernameController,
                    backgroundColor: Colors.transparent,
                    labelStyle: const TextStyle(color: OTTColors.white),
                    textColor: OTTColors.whiteColor,
                    showLabel: false,
                  ),
                  const SizedBox(height: 20),

                  // Save Button
                  CustomButton(
                    text: "Save Changes",
                    gradient: LinearGradient(
                      colors: [OTTColors.buttoncolour, OTTColors.buttoncolour1],
                    ),
                    onPressed: () {
                      // Save profile API call here
                      Get.snackbar(
                        "Success",
                        "Profile updated successfully!",
                        backgroundColor: Colors.white.withOpacity(0.1),
                        colorText: Colors.white,
                      );
                    },
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
