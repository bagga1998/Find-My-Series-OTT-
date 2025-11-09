import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle; // ✅ Added fontStyle
  final Color color;
  final String fontFamily;
  final TextOverflow overflow;
  final int? maxLines;
  final TextDecoration? textDecoration;
  final VoidCallback? onTap;
  final Gradient? gradient;

  const CustomText({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal, // ✅ Default normal
    this.color = Colors.black,
    this.fontFamily = 'PrimaryFont',
    this.overflow = TextOverflow.visible,
    this.maxLines,
    this.textDecoration,
    this.onTap,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle;

    // Create gradient shader if gradient is provided
    final shader = gradient?.createShader(
      Rect.fromLTWH(0, 0, text.length * fontSize, fontSize),
    );

    try {
      // ✅ Try using Google Font
      textStyle = GoogleFonts.getFont(
        fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle, // ✅ Apply fontStyle
        decoration: textDecoration,
        color: gradient == null ? color : null,
        foreground: gradient != null ? (Paint()..shader = shader!) : null,
      );
    } catch (e) {
      // ✅ Fallback to normal TextStyle (for local fonts)
      textStyle = TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle, // ✅ Apply fontStyle here too
        decoration: textDecoration,
        color: gradient == null ? color : null,
        foreground: gradient != null ? (Paint()..shader = shader!) : null,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Text(
        text.tr,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        style: textStyle,
      ),
    );
  }
}
