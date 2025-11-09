// ignore_for_file: deprecated_member_use, constant_identifier_names

import 'package:flutter/material.dart';

class OTTColors {
  OTTColors._();

  // Primary & Secondary Colors
  static const Color primary = Color(0xFF4b68ff);
  static const Color primary1 = Color(0xFFFA6C12);
  static const Color secondary = Color(0xFFFFE248);
  static const Color accent = Color(0xFFb8c7ff);
  static const Color accent1 = Color(0xFFFF77D7);

  // Text Colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C7570);
  static const Color textSecondary1 = Color(0xFF757575);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFFFF8E1);
  static const Color snowWhite = Color(0xFFFFFAFA);
  static const Color textMain = Color(0xFF212121);

  // Background Colors
  static const Color background = Color(0xFFF9F9F9);
  static const Color backgroundDialogue = Color(0xFF0E2328);
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);
  static Color darkContainer = OTTColors.textWhite.withOpacity(8.1);
  static const Color lightContainer = Color(0xFFF6F6F6);
  static const Color cardBackground = Color(0xFFFFFFFF);


  // Miscellaneous Colors
  static const Color black = Color(0xFF232323);
  static const Color black1 = Color(0xFF020100);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color lightgrey = Color(0xFFDEDEDE);
  static const Color bottom = Color(0xFFEEEDED);
  static const Color welcomeContainer = Color(0xFF1EC756);
  static const Color onboarding1textcolor = Color(0xFF787878);

  // Gradient Colors
  static Gradient linerGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color.fromARGB(255, 38, 71, 86),
      Color(0xFF203A43),
      Color(0xFF2C5364),
    ],
  );

  static Gradient buttonGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xFFF70100),
      Color(0xFF232323),
    ],
  );
  // Text main color
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color preferredServices = Color(0xFFCDCDD0);
  static const Color white = Colors.white70;

  // Welcome Screen Colors
  static const Color FindMySeries = Color(0xFFBA66F0);
  static const Color buildandManage = Color(0xFFBA66F0);
  static const Color rateandreview = Color(0xFFBA66F0);
  static const Color discoverContent = Color(0xFFBA66F0);
  static const Color yourWatchlist = Color(0xFFCDCDD0);
  static const Color Signrecommendations = Color(0xFFCDCDD0);

  // Appbar
  static const Color appbar = Color(0xFF2b1d34);
  static const Color appbarSteps1 = Color(0xFFBA66F0);
  static const Color appbarSteps2 = Color(0xFF742DFF);


  // Button Colour
  static const Color buttoncolour = Color(0xFFBA66F0);
  static const Color buttoncolour1 = Color(0xFF742DFF);

  // icon Colour
  static const Color icon = Color(0xFFFBC928);



}
