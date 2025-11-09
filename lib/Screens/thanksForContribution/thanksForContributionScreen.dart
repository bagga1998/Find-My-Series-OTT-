import 'package:find_my_series/Screens/Movie%20details%20screen/movieDetailsScreen.dart';
import 'package:find_my_series/widgets/button.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ThanksforContributionScreen extends StatefulWidget {
  const ThanksforContributionScreen({super.key});

  @override
  State<ThanksforContributionScreen> createState() =>
      _ThanksforContributionScreenState();
}

class _ThanksforContributionScreenState
    extends State<ThanksforContributionScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/background.svg',
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                right: 20.0,
                left: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Movie info card
                  Container(
                    padding: EdgeInsets.all(width * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.22,
                          height: height * 0.12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage('assets/md1.png'),
                              // fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.04),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: "Kantara: A Legend – Chapter 1",
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'DM Sans',
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  CustomText(
                                    text: "Language: ",
                                    color: OTTColors.preferredServices,
                                    fontSize: 13,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w600,
                                  ),

                                  CustomText(
                                    text: "Hindi, Tamil, Telugu",
                                    color: OTTColors.preferredServices,
                                    fontSize: 13,
                                    fontFamily: 'DM Sans',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              CustomText(
                                text: "2015  •  UA 16+  •  2h 45m",
                                color: OTTColors.preferredServices,
                                fontSize: 12,
                                fontFamily: 'DM Sans',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.04),
                  CustomText(
                    text: "Thankyou for your Contribution!",
                    color: OTTColors.whiteColor,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),

                  SizedBox(height: height * 0.01),
                  CustomText(
                    text:
                        "Our team is currently reviewing the information you’ve provided.",
                    color: OTTColors.preferredServices,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),

                  SizedBox(height: height * 0.01),
                  CustomText(
                    text:
                        "We strive to process all submissions as efficiently as possible, though processing times may vary depending on the type of data shared.  A confirmation email has been sent to your registered address, and you’ll soon be able to monitor your submission’s progress in your ",
                    color: OTTColors.preferredServices,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                  CustomText(
                    text: "Contribution History",
                    color: OTTColors.buttoncolour,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  Spacer(),
                  CustomButton(
                    text: 'Close',
                    onPressed: () {
                      Get.offUntil(
                        MaterialPageRoute(builder: (_) => MovieDetailsScreen(movieId: "1",)),
                        (route) => route.isFirst,
                      );
                    },
                    gradient: LinearGradient(
                      colors: [OTTColors.buttoncolour, OTTColors.buttoncolour1],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
