import 'dart:ui';
import 'package:find_my_series/auth/Login%20with%20email/loginScreen.dart';
import 'package:find_my_series/widgets/button.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:find_my_series/widgets/textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Submitrequestform extends StatelessWidget {
  const Submitrequestform({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 600;

    double spacing(double space) => isTablet ? space * 1.2 : space;
    double fontSize(double size) => isTablet ? size * 1.2 : size;

    final TextEditingController titleController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController queryController = TextEditingController();

    // 🔹 Glassmorphic Wrapper Widget
    Widget glassField({required Widget child}) {
      return ClipRRect(
        // borderRadius: BorderRadius.circular(1),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: child,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.1),
      body: SafeArea(
        child: Stack(
          children: [
            /// 🔹 Background SVG
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/background.svg',
                fit: BoxFit.cover,
              ),
            ),

            /// 🔹 Main Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// 🔹 Back Button
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color.fromARGB(137, 100, 99, 99),
                                  width: 1.5,
                                ),
                              ),
                              child: IconButton(
                                onPressed: () => Get.back(),
                                icon: const Icon(Icons.arrow_back,
                                    color: OTTColors.buttoncolour),
                                iconSize: 22,
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(),
                              ),
                            ),
                            SizedBox(height: height * 0.04),

                            /// 🔹 Header Text
                            CustomText(
                              text: "Submit your query/Feedback",
                              color: OTTColors.buttoncolour,
                              fontSize: fontSize(26),
                              fontWeight: FontWeight.w700,
                              fontFamily: 'DM Sans',
                            ),
                            SizedBox(height: spacing(6)),
                            CustomText(
                              text: "For Any Query, Contact us",
                              color: Colors.white70,
                              fontSize: fontSize(16),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'DM Sans',
                            ),
                            SizedBox(height: height * 0.03),

                            /// 🔹 Full Name Field
                            CustomText(
                              text: "Full Name",
                              color: OTTColors.preferredServices,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'DM Sans',
                            ),
                            const SizedBox(height: 8),
                            glassField(
                              child: CustomTextFormField(
                                label: 'Enter Your Name',
                                controller: titleController,
                                backgroundColor: Colors.transparent,
                                labelStyle: TextStyle(color: OTTColors.white),
                                showLabel: false,
                                hintStyle: TextStyle(color: Colors.white54),
                                borderColor: Colors.transparent,
                                textColor: OTTColors.white,
                                height: isTablet ? 68 : 56,
                                width: isTablet ? 456 : 380,
                              ),
                            ),

                            SizedBox(height: height * 0.03),

                            /// 🔹 Email Field
                            CustomText(
                              text: "Email Address",
                              color: OTTColors.preferredServices,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'DM Sans',
                            ),
                            const SizedBox(height: 8),
                            glassField(
                              child: CustomTextFormField(
                                label: 'Enter Email Address',
                                controller: emailController,
                                backgroundColor: Colors.transparent,
                                labelStyle: TextStyle(color: OTTColors.white),
                                showLabel: false,
                                hintStyle: TextStyle(color: Colors.white54),
                                borderColor: Colors.transparent,
                                textColor: OTTColors.white,
                                height: isTablet ? 68 : 56,
                                width: isTablet ? 456 : 380,
                              ),
                            ),

                            SizedBox(height: height * 0.03),

                            /// 🔹 Phone Field
                            CustomText(
                              text: "Phone Number",
                              color: OTTColors.preferredServices,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'DM Sans',
                            ),
                            const SizedBox(height: 8),
                            glassField(
                              child: CustomTextFormField(
                                label: '00000 00000',
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                backgroundColor: Colors.transparent,
                                labelStyle: TextStyle(color: OTTColors.white),
                                showLabel: false,
                                hintStyle: TextStyle(color: Colors.white54),
                                borderColor: Colors.transparent,
                                textColor: OTTColors.white,
                                height: isTablet ? 68 : 56,
                                width: isTablet ? 456 : 380,
                              ),
                            ),

                            SizedBox(height: height * 0.03),

                            /// 🔹 Query Field
                            CustomText(
                              text: "Your Question or Query",
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'DM Sans',
                            ),
                            const SizedBox(height: 8),
                            glassField(
                              child: CustomTextFormField(
                                label: 'Please describe your question or query',
                                controller: queryController,
                                backgroundColor: Colors.transparent,
                                labelStyle: TextStyle(color: OTTColors.white),
                                showLabel: false,
                                hintStyle: TextStyle(color: Colors.white54),
                                textColor: OTTColors.white,
                                borderColor: Colors.transparent,
                                height: height * 0.25,
                              ),
                            ),

                            SizedBox(height: spacing(height * 0.03)),

                            /// 🔹 Submit Button
                            Center(
                              child: CustomButton(
                                text: 'Submit Request Form',
                                onPressed: () => Get.to(const Loginscreen()),
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

                            /// 🔹 Footer
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
