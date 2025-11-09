import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:find_my_series/widgets/colors.dart';

class GlassCard extends StatelessWidget {
  final double? width;
  final double? height;

  // Accept both
  final IconData? iconData; // ✅ for Icons
  final Widget? iconWidget; // ✅ for Images, SVGs, etc.

  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const GlassCard({
    super.key,
    this.width,
    this.height,
    this.iconData,
    this.iconWidget,
    required this.title,
    required this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
  }) : assert(
         iconData != null || iconWidget != null,
         "You must provide either iconData or iconWidget",
       );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive scaling factor (base width ~ 390 iPhone 12 screen)
    double scale = screenWidth / 390;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16 * scale),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: width ?? screenWidth * 9,
          height: height ?? 95 * scale,
          padding: EdgeInsets.all(16 * scale),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16 * scale),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.2 * scale,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 28 * scale,
                width: 28 * scale,
                child:
                    iconWidget ??
                    Icon(iconData, color: Colors.white, size: 28 * scale),
              ),
              SizedBox(width: 16 * scale),
              Flexible(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // ⬅ centers text vertically
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize:
                      MainAxisSize.min, // ⬅ prevents taking extra height
                  children: [
                    Text(
                      title,
                      style:
                          titleStyle ??
                          TextStyle(
                            color: OTTColors.buildandManage,
                            fontSize: 16 * scale,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DM Sans',
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 4 * scale,
                    ), // ⬅ spacing between title & subtitle
                    Text(
                      subtitle,
                      style:
                          subtitleStyle ??
                          TextStyle(
                            color: Colors.white70,
                            fontSize: 14 * scale,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
