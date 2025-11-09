import 'dart:io';
import 'dart:ui';

import 'package:find_my_series/widgets/appBar.dart';
import 'package:find_my_series/widgets/button.dart';
import 'package:find_my_series/widgets/colors.dart';
import 'package:find_my_series/widgets/font-styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class StorageScreen extends StatefulWidget {
  final List<String> pagePath;
  const StorageScreen({
    super.key,
    this.pagePath = const ['Profile', 'Settings', 'Video'],
  });

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
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
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
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
                        text: 'Storage',
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
                    text: 'Delete Cache',
                    color: OTTColors.whiteColor,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  const SizedBox(height: 6),
                  CustomText(
                    text: 'You can free up storage by deleting your cache',
                    color: OTTColors.preferredServices,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  SizedBox(height: Get.height * 0.03),
                  Center(
                    child: CustomButton(
                      // height: Get.height * 0.06,
                      // width: Get.width * 0.4,
                      text: 'Delete Cache',
                      textStyle: TextStyle(
                        fontSize: 13,
                        color: OTTColors.whiteColor,
                      ),
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 15,
                                    sigmaY: 15,
                                  ),
                                  child: AlertDialog(
                                    elevation: 0,
                                    backgroundColor: Colors.white.withOpacity(
                                      0.08,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                        color: OTTColors.buttoncolour
                                            .withOpacity(0.4),
                                      ),
                                    ),
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.warning_amber_rounded,
                                          color: OTTColors.buttoncolour,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Confirm Action',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    content: const Text(
                                      'Are you sure you want to delete the app cache?\n\n'
                                      'This action will free up storage',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'DM Sans',
                                        fontSize: 14,
                                      ),
                                    ),
                                    actionsAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 10,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            side: const BorderSide(
                                              color: Colors.white24,
                                            ),
                                          ),
                                        ),
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              OTTColors.buttoncolour,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 22,
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          elevation: 4,
                                        ),
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: const Text(
                                          'Yes, Clear',
                                          style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );

                        if (confirmed == true) {
                          await clearAppCache(context);
                        }
                      },

                      gradient: LinearGradient(
                        colors: [
                          OTTColors.buttoncolour,
                          OTTColors.buttoncolour1,
                        ],
                      ),
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

      Future<double> _getCacheSizeMB() async {
  final tempDir = await getTemporaryDirectory();

  double totalSize = 0;

  if (tempDir.existsSync()) {
    totalSize = _getDirectorySize(tempDir) / (1024 * 1024); // Convert bytes → MB
  }

  return totalSize;
}

double _getDirectorySize(Directory dir) {
  double size = 0;
  try {
    if (dir.existsSync()) {
      final files = dir.listSync(recursive: true, followLinks: false);
      for (final file in files) {
        if (file is File) {
          size += file.lengthSync();
        }
      }
    }
  } catch (e) {
    debugPrint("Error calculating cache size: $e");
  }
  return size;
}


Future<void> clearAppCache(BuildContext context) async {
  try {
    final tempDir = await getTemporaryDirectory();

    // Get cache size before deleting
    final double cacheBefore = await _getCacheSizeMB();

    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }

    // Also clear Flutter image memory cache (optional)
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();

    final clearedMB = cacheBefore.toStringAsFixed(2);

    _showModernMessage(
      context,
      'Cache cleared successfully — freed up $clearedMB MB!',
      OTTColors.buttoncolour,
    );
    print('Cache cleared: $clearedMB MB freed.');
  } catch (e) {
    _showModernMessage(
      context,
      'Failed to clear cache: $e',
      Colors.redAccent,
    );
  }
}

  void _showModernMessage(BuildContext context, String message, Color color) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentMaterialBanner();

    final banner = MaterialBanner(
      backgroundColor: Colors.transparent,
      elevation: 0,
      dividerColor: Colors.transparent,
      content: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              border: Border.all(color: color.withOpacity(0.6), width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.notifications_active_rounded, color: color),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: const [SizedBox.shrink()],
    );

    messenger.showMaterialBanner(banner);

    Future.delayed(const Duration(seconds: 3), () {
      // Ensure the messenger is still mounted before hiding
      if (messenger.mounted) messenger.hideCurrentMaterialBanner();
    });
  }
}
