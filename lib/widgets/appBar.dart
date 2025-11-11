// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.titleText,
    this.titleTextStyle,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow,
    this.backgroundColor,
    this.elevation,
    this.borderColor,
    this.blurColor,
    this.leadingIconColor,
    this.gradient,
    this.bottom,
    this.leadingText,
    this.leadingTextStyle,
    this.centerTitle = false,
    this.titleGradient,
    this.leadingImage,
    this.leadingSvg,
    this.leadingImageHeight = 24,
    this.leadingImageWidth = 24,
    this.customBackgroundColor,
    this.leadingIconSize, // 👈 NEW FIELD
  });

  final String? titleText;
  final TextStyle? titleTextStyle;
  final bool? showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final Color? backgroundColor;
  final double? elevation;
  final Color? borderColor;
  final Color? blurColor;
  final Color? leadingIconColor;
  final double? leadingIconSize; // 👈 NEW FIELD
  final Gradient? gradient;
  final PreferredSizeWidget? bottom;
  final String? leadingText;
  final TextStyle? leadingTextStyle;
  final bool centerTitle;
  final Gradient? titleGradient;
  final String? leadingImage;
  final String? leadingSvg;
  final double leadingImageHeight;
  final double leadingImageWidth;
  final Color? customBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor:
          customBackgroundColor ?? backgroundColor ?? Colors.transparent,
      elevation: elevation ?? 0,
      bottom: bottom,
      flexibleSpace: ClipRRect(
        borderRadius: BorderRadius.zero,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: customBackgroundColor,
              gradient: customBackgroundColor == null
                  ? (gradient ??
                        const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF161218), Color(0xFF2B1D34)],
                        ))
                  : null,
              border: borderColor != null
                  ? Border(bottom: BorderSide(color: borderColor!, width: 1))
                  : null,
            ),
          ),
        ),
      ),
      titleSpacing: 0,
      centerTitle: centerTitle,
      title: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Centered gradient title
              if (titleText != null)
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) {
                    if (titleGradient != null) {
                      return titleGradient!.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      );
                    }
                    return const LinearGradient(
                      colors: [Colors.white, Colors.white],
                    ).createShader(Rect.zero);
                  },
                  child: Text(
                    titleText!,
                    textAlign: TextAlign.center,
                    style:
                        titleTextStyle ??
                        const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'DM Sans',
                        ),
                  ),
                ),

              // Leading Section
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 8),

                    // 👇 SVG support
                    if (leadingSvg != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 6),
                        child: SvgPicture.asset(
                          leadingSvg!,
                          height: leadingImageHeight,
                          width: leadingImageWidth,
                        ),
                      ),

                    // 👇 Image support
                    if (leadingImage != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 6),
                        child: Image.asset(
                          leadingImage!,
                          height: leadingImageHeight,
                          width: leadingImageWidth,
                        ),
                      ),

                    // 👇 Icon with customizable size
                    if (showBackArrow ?? false)
                      IconButton(
                        onPressed:
                            leadingOnPressed ??
                            () => Navigator.of(context).pop(),
                        icon: Icon(
                          leadingIcon ?? Icons.arrow_back,
                          color: leadingIconColor ?? Colors.white,
                          size: leadingIconSize ?? 24, // 👈 size applied here
                        ),
                      ),

                    // 👇 Optional leading text
                    // 👇 Optional leading text with tap support
                    if (leadingText != null)
                      GestureDetector(
                        onTap: leadingOnPressed,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            leadingText!,
                            style:
                                leadingTextStyle ??
                                const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'DM Sans',
                                ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Actions section
              if (actions != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions!,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize {
    final double bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}
