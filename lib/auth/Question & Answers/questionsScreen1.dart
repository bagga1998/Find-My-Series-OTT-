import 'dart:ui';
import 'package:find_my_series/auth/Question%20&%20Answers/questionsScreen2.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class QuestionListScreen extends StatefulWidget {
  const QuestionListScreen({super.key});

  @override
  State<QuestionListScreen> createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  // Mock question data
  final List<Map<String, dynamic>> questionData = [
    {
      "question":
          "What kind of experience do you usually look for while watching something?",
      "options": [
        "Thought-provoking",
        "Light & Fun",
        "Exciting & Thrilling",
        "Emotional & Heart-touching",
        "Visual / Musical",
      ],
    },
    {
      "question": "Which genre do you prefer the most?",
      "options": ["Action", "Drama", "Comedy", "Romance", "Documentary"],
    },
  ];

  // To store selected answers
  Map<int, String> selectedAnswers = {};

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
                  Get.to(QuestionsScreen2());
                },
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 🔹 Background SVG (same as BornToday)
          Positioned.fill(
            child: SvgPicture.asset('assets/background.svg', fit: BoxFit.cover),
          ),

          // 🔹 Foreground Content
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: height * 0.025,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  CustomText(
                    text:
                        'To give you a better experience, Answer a few quick questions.',
                    color: OTTColors.buttoncolour,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),

                  CustomText(
                    text: 'Questions(1-9)',
                    color: OTTColors.preferredServices,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  SizedBox(height: height * 0.02),

                  // 🔹 Question List
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: questionData.length,
                    itemBuilder: (context, index) {
                      final question = questionData[index];
                      final String questionText = question["question"];
                      final List options = question["options"];

                      return Container(
                        margin: EdgeInsets.only(bottom: height * 0.025),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
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

                                // Options
                                ...options.map((option) {
                                  final bool isSelected =
                                      selectedAnswers[index] == option;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // Toggle behaviour:
                                        // if already selected -> deselect,
                                        // otherwise select this option (and implicitly deselect previous)
                                        if (selectedAnswers[index] == option) {
                                          selectedAnswers.remove(index);
                                        } else {
                                          selectedAnswers[index] = option;
                                        }
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 250,
                                      ),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                        horizontal: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(12),
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
                                            text:  option,
                                                color: OTTColors.preferredServices,
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
            ),
          ),
        ],
      ),
    );
  
  }
}
