import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:find_my_series/Screens/thanksForContribution/thanksForContributionScreen.dart';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/button.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:find_my_series/widgets/textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3_plus/record_mp3_plus.dart';

class AddUsersReviewsScreen extends StatefulWidget {
  const AddUsersReviewsScreen({super.key});

  @override
  State<AddUsersReviewsScreen> createState() => _AddUsersReviewsScreenState();
}

class _AddUsersReviewsScreenState extends State<AddUsersReviewsScreen> {
  int selectedStars = 0;
  String? spoilerSelection;
  String? ratingwithemojisSection;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  //  final bool hasText = reviewController.text.isNotEmpty;

  String? filePath;
  String statusText = "";
  bool isComplete = false;
  bool _isRecording = false;
  bool _isRecorded = false;
  bool _isPlaying = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _audioPlayer.dispose();
    titleController.dispose();
    reviewController.dispose();
    super.dispose();
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

 // 📤 Send the voice note
void _sendVoiceNote() async {
  if (recordFilePath == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please record a voice note first.")),
    );
    return;
  }

  await _audioPlayer.stop(); // stop playback if running

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Voice note sent: $recordFilePath")),
  );

  setState(() {
    _isRecorded = false;
    recordFilePath = null;
    _isPlaying = false;
  });
}


  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      print('Recording to $recordFilePath');
      isComplete = false;
      RecordMp3.instance.start(recordFilePath!, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        statusText = "Recording...";
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Recording pause...";
        setState(() {});
      }
    }
  }

 void _deleteAudio() async {
  // Stop playback if it’s playing
  if (_isPlaying) {
    await _audioPlayer.stop();
    setState(() => _isPlaying = false);
  }

  // Delete file if it exists
  if (recordFilePath != null && File(recordFilePath!).existsSync()) {
    File(recordFilePath!).deleteSync();
  }

  // Reset state
  setState(() {
    _isRecorded = false;
    recordFilePath = null;
  });
}

  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Record complete";
      isComplete = true;
      setState(() {});
    }
  }

  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Recording...";
      setState(() {});
    }
  }

  String? recordFilePath;

  void play() {
    if (recordFilePath != null && File(recordFilePath!).existsSync()) {
      AudioPlayer audioPlayer = AudioPlayer();
      audioPlayer.play(DeviceFileSource(recordFilePath!));
    }
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingText: 'BACK TO HOMEPAGE',
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
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),

          /// Main content
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.06,
              vertical: height * 0.12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.015),

                //Add User Review Section
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: Get.height * 0.030,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB968F0),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(width: 10),
                    CustomText(
                      text: "Add User Reviews",
                      color: OTTColors.buttoncolour,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.015),

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

                /// Rating section
                const Text(
                  "Your Rating",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: height * 0.012),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(10, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedStars = index + 1;
                            });
                          },
                          child: Icon(
                            Icons.star,
                            size: width * 0.07,
                            color: index < selectedStars
                                ? Colors.amber
                                : Colors.white24,
                          ),
                        );
                      }),
                    ),
                    CustomText(
                      text: "${selectedStars.toString()}/10",
                      color: OTTColors.buttoncolour,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DM Sans',
                    ),
                  ],
                ),

                SizedBox(height: height * 0.035),
                // SizedBox(height: height * 0.01),
                /// Rating with emojis section
                const Text(
                  "How was the movie?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: height * 0.015),

                Row(
                  children: [
                    _buildEmojiOption(
                      context,
                      title: "Mind-blowing",
                      emoji: "🤯",
                      value: "Mind-blowing",
                      selectedValue: ratingwithemojisSection,
                      onChanged: (val) =>
                          setState(() => ratingwithemojisSection = val),
                    ),
                    Spacer(),
                    _buildEmojiOption(
                      context,
                      title: "Loved it",
                      emoji: "😍",
                      value: "Loved it",
                      selectedValue: ratingwithemojisSection,
                      onChanged: (val) =>
                          setState(() => ratingwithemojisSection = val),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.012),
                Row(
                  children: [
                    _buildEmojiOption(
                      context,
                      title: "Average",
                      emoji: "😐",
                      value: "Average",
                      selectedValue: ratingwithemojisSection,
                      onChanged: (val) =>
                          setState(() => ratingwithemojisSection = val),
                    ),
                    Spacer(),
                    _buildEmojiOption(
                      context,
                      title: "Boring",
                      emoji: "😴",
                      value: "Boring",
                      selectedValue: ratingwithemojisSection,
                      onChanged: (val) =>
                          setState(() => ratingwithemojisSection = val),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.012),
                Center(
                  child: _buildEmojiOption(
                    context,
                    title: "Disappointed",
                    emoji: "😡",
                    value: "Disappointed",
                    selectedValue: ratingwithemojisSection,
                    onChanged: (val) =>
                        setState(() => ratingwithemojisSection = val),
                  ),
                ),

                SizedBox(height: height * 0.035),
                CustomTextFormField(
                  label: 'Add Title of Your Review',
                  controller: titleController,
                  backgroundColor: Colors.white.withOpacity(0.06),
                  hintStyle: TextStyle(color: OTTColors.white),
                  labelStyle: TextStyle(color: OTTColors.white),
                  showLabel: false,
                  fontFamily: 'DM Sans',
                  textColor: OTTColors.white,
                  borderColor: Colors.white24,
                ),

                SizedBox(height: height * 0.02),

                /// Review text field
                /// --- Review Text Field + Voice Note Section ---
                Stack(
                  children: [
                    CustomTextFormField(
                      label: 'Add Your Review Here',
                      controller: reviewController,
                      backgroundColor: Colors.white.withOpacity(0.06),
                      hintStyle: TextStyle(color: OTTColors.white),
                      showLabel: false,
                      textColor: OTTColors.white,
                      height: height * 0.19,
                      borderColor: Colors.white24,
                      onChanged: (_) => setState(() {}),
                    ),
                    // 🎤 Mic + Audio Controls
                    if (reviewController.text.isEmpty)
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: OTTColors.buttoncolour.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: !_isRecording && !_isRecorded
                              // 🎙 Mic Button
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.mic,
                                    color: Colors.purpleAccent,
                                  ),
                                  onPressed: () async {
                                    setState(() => _isRecording = true);
                                    startRecord();
                                  },
                                )
                              // 🔴 Stop Recording
                              : _isRecording
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.stop,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    stopRecord();
                                    setState(() {
                                      _isRecording = false;
                                      _isRecorded = true;
                                    });
                                  },
                                )
                              // ▶️ Play / 🗑️ Delete / 📤 Send Buttons
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        _isPlaying
                                            ? Icons.stop
                                            : Icons.play_arrow,
                                        color: Colors.greenAccent,
                                      ),
                                      onPressed: _isPlaying
                                          ? _audioPlayer.stop
                                          : () async {
                                              if (recordFilePath != null) {
                                                await _audioPlayer.play(
                                                  DeviceFileSource(
                                                    recordFilePath!,
                                                  ),
                                                );
                                                setState(
                                                  () => _isPlaying = true,
                                                );
                                                _audioPlayer.onPlayerComplete
                                                    .listen((_) {
                                                      setState(
                                                        () =>
                                                            _isPlaying = false,
                                                      );
                                                    });
                                              }
                                            },
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: _deleteAudio,
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.send,
                                        color: Colors.blueAccent,
                                      ),
                                      onPressed: _sendVoiceNote,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: height * 0.03),

                /// Spoiler question
                const CustomText(
                  text: "Does this User Review contain spoilers?",
                  color: OTTColors.preferredServices,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'DM Sans',
                ),
                SizedBox(height: height * 0.01),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.2,
                      child: Radio<String>(
                        value: "Yes",
                        groupValue: spoilerSelection,
                        activeColor: OTTColors.buttoncolour,
                        onChanged: (val) =>
                            setState(() => spoilerSelection = val),
                      ),
                    ),
                    const CustomText(
                      text: "Yes",
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(width: width * 0.08),
                    Transform.scale(
                      scale: 1.2,
                      child: Radio<String>(
                        value: "No",
                        groupValue: spoilerSelection,
                        activeColor: Colors.purpleAccent,
                        onChanged: (val) =>
                            setState(() => spoilerSelection = val),
                      ),
                    ),
                    const CustomText(
                      text: "No",
                      color: OTTColors.preferredServices,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),

                SizedBox(height: height * 0.02),

                /// Terms text
                SizedBox(width: width * 0.02),
                CustomText(
                  text:
                      "I agree to the Terms & Conditions. The data I'm submitting is true and not copyrighted by a third party.",
                  color: Colors.white60,
                  fontSize: 12,
                ),

                SizedBox(height: height * 0.04),

                /// Buttons
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Cancel',
                        onPressed: () {},
                        backgroundColor: Colors.white.withOpacity(0.06),
                        borderColor: OTTColors.buttoncolour,
                      ),
                    ),
                    SizedBox(width: width * 0.05),
                    Expanded(
                      child: CustomButton(
                        text: 'Submit',
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: OTTColors.whiteColor,
                          fontFamily: 'DM Sans',
                        ),
                        onPressed: () {
                          Get.to(const ThanksforContributionScreen());
                        },
                        // backgroundColor:
                        gradient: LinearGradient(
                          colors: [
                            OTTColors.buttoncolour,
                            OTTColors.buttoncolour1,
                          ],
                        ),

                        // borderColor: OTTColors.buttoncolour,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildEmojiOption(
  BuildContext context, {
  required String title,
  required String emoji,
  required String value,
  required String? selectedValue,
  required ValueChanged<String?> onChanged,
}) {
  final width = MediaQuery.of(context).size.width;
  final bool isSelected = value == selectedValue;

  // 🔹 Responsive scaling
  final bool isTablet = width >= 600 && width < 1024;
  final bool isDesktop = width >= 1024;

  final double horizontalPadding = isDesktop
      ? 24
      : isTablet
          ? 18
          : width * 0.035;

  final double verticalPadding = isDesktop
      ? 14
      : isTablet
          ? 12
          : width * 0.02;

  final double circleSize = isDesktop
      ? 28
      : isTablet
          ? 22
          : width * 0.045;

  final double fontSize = isDesktop
      ? 16
      : isTablet
          ? 14
          : width * 0.035;

  return GestureDetector(
    onTap: () => onChanged(isSelected ? null : value),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      margin: EdgeInsets.symmetric(horizontal: width * 0.01, vertical: 4),
      constraints: BoxConstraints(
        maxWidth: width * 0.45, // 🔹 Prevent overflow on smaller screens
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected
              ? const Color(0xFFB968F0)
              : Colors.white.withOpacity(0.15),
          width: isSelected ? 1.6 : 1,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xFFB968F0).withOpacity(0.25),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Radio circle
          Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? const Color(0xFFB968F0)
                    : Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: isSelected
                ? Container(
                    margin: EdgeInsets.all(circleSize * 0.25),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFB968F0),
                    ),
                  )
                : const SizedBox(),
          ),

          SizedBox(width: width * 0.02),

          // Emoji and title text
          Flexible(
            child: Text(
              "$emoji  $title",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'DM Sans',
                fontSize: fontSize,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}
