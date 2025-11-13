import 'dart:ui';
import 'package:find_my_series/auth/Question%20&%20Answers/questionsController.dart';
import 'package:find_my_series/auth/Question%20&%20Answers/questionsScreen2.dart';
import 'package:find_my_series/auth/Question%20&%20Answers/saveQuestionsController.dart';
import 'package:find_my_series/auth/SignIn%20with%20social%20media/socialMediaSignInScreen.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/bottomBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionListScreen extends StatefulWidget {
  const QuestionListScreen({super.key});

  @override
  State<QuestionListScreen> createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  final QuesController getQuestionController = Get.put(QuesController());
  final SurveyController saveSurveyQuestions = Get.put(SurveyController());

  // To store selected answers: key -> question_id, value -> selected_option_id
  Map<int, String> selectedAnswers = {};

  @override
  void initState() {
    super.initState();
    getQuestionController.fetchQuestions(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleText: 'STEPS 4 OF 5',
        leadingText: 'SKIP',
        leadingOnPressed: () {
          Get.to(QuestionsScreen2());
        },
        centerTitle: true,
        titleGradient: const LinearGradient(
          colors: [Color(0xFF9B51E0), Color(0xFFBB6BD9)],
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: width * 0.045,
          fontWeight: FontWeight.w400,
          fontFamily: 'DM Sans',
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF161218), Color(0xFF2B1D34)],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: CustomText(
                text: 'Next',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'DM Sans',
                onTap: () async {
  if (selectedAnswers.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          text: "Please select at least one answer!",
          color: OTTColors.whiteColor,
          fontFamily: "DM Sans",
        ),
        backgroundColor: OTTColors.black1,
      ),
    );
    return;
  }

  // ✅ Wait for API submission
  final success = await saveSurveyQuestions.submitAnswers(context, selectedAnswers);
if (success) {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('onboarding_completed', true);

  final token = prefs.getString('token') ?? '';
  if (token.isEmpty) {
    Get.off(() => const SocialMediaSignInScreen());
  } else {
    Get.off(() => const bottomNavBar());
  }
} else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          text: "Failed to save answers. Please try again.",
          color: OTTColors.whiteColor,
          fontFamily: "DM Sans",
        ),
        backgroundColor: OTTColors.black1,
      ),
    );
  }
}

              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 🔹 Background SVG (same as your app’s theme)
          Positioned.fill(
            child: SvgPicture.asset('assets/background.svg', fit: BoxFit.cover),
          ),

          // 🔹 Foreground content
          SafeArea(
            child: Obx(() {
              if (getQuestionController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF9B51E0)),
                );
              }

              if (getQuestionController.questionsList.isEmpty) {
                return Center(
                  child: CustomText(
                    text: "No questions available.",
                    color: OTTColors.preferredServices,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.025,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text:
                          'To give you a better experience, Answer a few quick questions.',
                      color: OTTColors.buttoncolour,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                    CustomText(
                      text:
                          'Questions(1-${getQuestionController.questionsList.length})',
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    SizedBox(height: height * 0.02),

                    // 🔹 Question List (API integrated)
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: getQuestionController.questionsList.length,
                      itemBuilder: (context, index) {
                        final question =
                            getQuestionController.questionsList[index];

                        final questionText = question.questionText ?? '';
                        final int questionId = question.id ?? index + 1;
                        final List options = question.surveyOptions ?? [];

                        return Container(
                          margin: EdgeInsets.only(bottom: height * 0.025),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 1.0,
                                sigmaY: 1.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Question ${index + 1}:",
                                    color: OTTColors.buttoncolour,
                                    fontSize: width * 0.045,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "DM Sans",
                                  ),
                                  const SizedBox(height: 8),
                                  CustomText(
                                    text: questionText,
                                    color: OTTColors.whiteColor,
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "DM Sans",
                                  ),
                                  const SizedBox(height: 16),

                                  // Options from API
                                  ...options.map((option) {
                                    final int optionId = option.id ?? 0;
                                    final bool isSelected =
                                        selectedAnswers[questionId] ==
                                            optionId.toString();

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (selectedAnswers[questionId] ==
                                              optionId.toString()) {
                                            selectedAnswers.remove(questionId);
                                          } else {
                                            selectedAnswers[questionId] =
                                                optionId.toString();
                                          }

                                          // ✅ Print selected IDs for debugging
                                          print(
                                              "✅ Selected -> Question ID: $questionId | Option ID: $optionId");
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 250),
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                          horizontal: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.05),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Colors.white24,
                                            width: 1.2,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              isSelected
                                                  ? Icons.radio_button_checked
                                                  : Icons.radio_button_off,
                                              color: isSelected
                                                  ? OTTColors.buttoncolour
                                                  : OTTColors.preferredServices,
                                              size: 22,
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: CustomText(
                                                text: option.optionText ?? '',
                                                color:
                                                    OTTColors.preferredServices,
                                                fontSize: width * 0.038,
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
