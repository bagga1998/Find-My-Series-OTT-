import 'dart:ui';
import 'package:find_my_series/auth/Help%20&%20Support/submitRequestForm.dart';
import 'package:find_my_series/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  Future<void> _launchEmail(String recipientEmail) async {
    final String senderEmail = 'gauravbagga955@gmail.com';

    String encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map(
            (MapEntry<String, String> e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
          )
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: recipientEmail,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Help & Support Request from Find My Series',
        'body':
            'Hello,\n\nI am writing to you from Find My Series app.\n\nPlease describe your query or issue below:\n\n\n\nThank you,\nFindMySeriesUser',
        'cc': senderEmail,
      }),
    );

    try {
      if (await canLaunch(emailLaunchUri.toString())) {
        await launch(emailLaunchUri.toString());
      } else {
        throw Exception('Could not launch email');
      }
    } catch (e) {
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(SnackBar(content: Text('Error launching email: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 600;

    double fontSize(double size) => isTablet ? size * 1.2 : size;
    double spacing(double space) => isTablet ? space * 1.2 : space;

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/background.svg',
                fit: BoxFit.cover,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        icon: const Icon(
                          Icons.arrow_back,
                          color: OTTColors.buttoncolour,
                        ),
                        iconSize: 22,
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    SizedBox(height: spacing(height * 0.04)),
                    CustomText(
                      text: "Help & Support",
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
                    SizedBox(height: spacing(height * 0.06)),
                    GestureDetector(
                      onTap: () async {
                        final Uri phoneUri = Uri(
                          scheme: 'tel',
                          path: '1800256655',
                        );
                        if (await canLaunchUrl(phoneUri)) {
                          await launchUrl(phoneUri);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Could not launch phone dialer'),
                            ),
                          );
                        }
                      },
                      child: _glassCard(
                        context,
                        icon: Icons.phone_in_talk_rounded,
                        title: "CUSTOMER CARE",
                        subtitle: "1800-256-655",
                        height: height,
                      ),
                    ),

                    SizedBox(height: spacing(height * 0.03)),
                    GestureDetector(
                      onTap: () {
                        _launchEmail('info@findmyseries.com');
                      },
                      child: _glassCard(
                        context,
                        icon: Icons.email_outlined,
                        title: "EMAIL US",
                        subtitle: "info@findmyseries.com",
                        height: height,
                      ),
                    ),
                    SizedBox(height: spacing(height * 0.04)),
                    Center(
                      child: CustomText(
                        text: "OR",
                        color: Colors.white70,
                        fontSize: fontSize(16),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'DM Sans',
                      ),
                    ),
                    SizedBox(height: spacing(height * 0.03)),
                    Center(
                      child: CustomButton(
                        text: 'Submit Request Form',
                        onPressed: () {
                          Get.to(Submitrequestform());
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
                    const Spacer(),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Terms & Conditions",
                              color: Colors.white60,
                              fontSize: fontSize(13),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'DM Sans',
                            ),
                            const Text(
                              " • ",
                              style: TextStyle(color: Colors.white54),
                            ),
                            CustomText(
                              text: "Privacy Policy",
                              color: Colors.white60,
                              fontSize: fontSize(13),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'DM Sans',
                            ),
                          ],
                        ),
                        SizedBox(height: spacing(6)),
                        CustomText(
                          text: "© 2025 - findmyseries.in",
                          color: Colors.white38,
                          fontSize: fontSize(12),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'DM Sans',
                        ),
                      ],
                    ),
                    SizedBox(height: spacing(10)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required double height,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: height * 0.015,
            horizontal: height * 0.01,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: OTTColors.buttoncolour.withOpacity(0.3),
                    width: 1.2,
                  ),
                ),
                child: Icon(icon, color: OTTColors.whiteColor, size: 28),
              ),
              SizedBox(height: height * 0.02),
              CustomText(
                text: title,
                color: OTTColors.buttoncolour,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'DM Sans',
              ),
              SizedBox(height: height * 0.006),
              CustomText(
                text: subtitle,
                color: Colors.white70,
                fontSize: 18,
                fontFamily: 'DM Sans',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
