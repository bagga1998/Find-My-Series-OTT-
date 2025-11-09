import 'dart:ui';
import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VideoScreen extends StatefulWidget {
  final List<String> pagePath;
  const VideoScreen({
    super.key,
    this.pagePath = const ['Profile', 'Settings', 'Video'],
  });

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  String _autoPlayValue = 'Wifi and Cellular';
  String _subtitleValue = 'On when muted';

  final List<String> autoPlayOptions = [
    'Wifi and Cellular',
    'Wifi Only',
    'Never Auto-Play',
  ];

  final List<String> subtitleOptions = [
    'On when muted',
    'Always on',
    'Off',
  ];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingText: 'BACK TO PREVIOUS PAGE',
        leadingTextStyle: const TextStyle(
          fontFamily: 'DM Sans',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: OTTColors.whiteColor,
        ),
        leadingIcon: Icons.arrow_back_ios_new_rounded,
        leadingIconSize: 18,
        leadingOnPressed: () => Get.back(),
        leadingIconColor: OTTColors.whiteColor,
        showBackArrow: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF161218), Color(0xFF2B1D34)],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: OTTColors.whiteColor),
          ),
        ],
      ),
      body: Stack(
        children: [
            Positioned.fill(
              child: SizedBox.expand(
                child: SvgPicture.asset(
                  'assets/background.svg',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              ),
            ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
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
                      const SizedBox(width: 10),
                      CustomText(
                        text: 'Video',
                        color: OTTColors.buttoncolour,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
              
                  /// Breadcrumb Path
                  Text(
                    widget.pagePath.join(' > '),
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 14,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  _divider(),
                  SizedBox(height: height * 0.01),
              
                  /// Auto-play Video Section
                  CustomText(
                    text: 'Auto-play Video',
                    color: OTTColors.whiteColor,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 6),
                  CustomText(
                    text:
                        'Enable to automatically play video muted at the top of title and name pages.',
                    color: OTTColors.preferredServices,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: Get.width * 0.5,
                    child: AutoPlayDropdown(
                      items: autoPlayOptions,
                      selectedValue: _autoPlayValue,
                      onChanged: (value) =>
                          setState(() => _autoPlayValue = value),
                    ),
                  ),
              
                  SizedBox(height: height * 0.018),
                  _divider(),
                  SizedBox(height: height * 0.01),
              
                  /// Subtitles and Captions Section
                  CustomText(
                    text: 'Subtitles and Captions',
                    color: OTTColors.whiteColor,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 6),
                  CustomText(
                    text:
                        'Set your preference for displaying subtitles and captions.',
                    color: OTTColors.preferredServices,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: Get.width * 0.5,
                    child: SubtitleDropdown(
                      items: subtitleOptions,
                      selectedValue: _subtitleValue,
                      onChanged: (value) =>
                          setState(() => _subtitleValue = value),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() =>
      Divider(color: Colors.white.withOpacity(0.1), thickness: 1);
}

/// ------------------------------
/// AutoPlay Dropdown Widget
/// ------------------------------
class AutoPlayDropdown extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String> onChanged;

  const AutoPlayDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.06,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: const Color(0xFF1F1A24),
          value: selectedValue,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          isExpanded: true,
          style: const TextStyle(
              color: Colors.white, fontFamily: 'DM Sans', fontSize: 14),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
          items: items.map((item) {
            final isSelected = item == selectedValue;
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  color: isSelected ? OTTColors.whiteColor : Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// ------------------------------
/// Subtitle Dropdown Widget
/// ------------------------------
class SubtitleDropdown extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String> onChanged;

  const SubtitleDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.06,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: const Color(0xFF1F1A24),
          value: selectedValue,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          isExpanded: true,
          style: const TextStyle(
              color: Colors.white, fontFamily: 'DM Sans', fontSize: 14),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
          items: items.map((item) {
            final isSelected = item == selectedValue;
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  color: isSelected ? OTTColors.whiteColor : Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
