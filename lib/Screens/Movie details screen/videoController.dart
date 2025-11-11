// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerControllerX extends GetxController {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  var isVideoInitialized = false.obs;
  var isPlaying = false.obs;
  var isMuted = false.obs;

  String? videoUrl;
  String? trailerUrl;

  /// Initialize video safely (network mp4 / direct URL)
  Future<void> initializeVideo(String videoUrl) async {
    try {
      print("🎬 Step 1: Starting initialization for video: $videoUrl");

      this.videoUrl = videoUrl;

      // Validate URL
      if (videoUrl.isEmpty || !Uri.tryParse(videoUrl)!.isAbsolute) {
        print("❌ Invalid video URL: $videoUrl");
        throw Exception("Invalid video URL");
      }

      // Create player
      print("⚙️ Step 2: Creating VideoPlayerController...");
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

      print("📦 Step 3: Initializing player...");
      await videoPlayerController.initialize().timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          print("⏰ Initialization timed out for: $videoUrl");
          throw Exception("Video initialization timed out");
        },
      );

      print("✅ Step 4: Player initialized successfully!");
      print("▶️ Duration: ${videoPlayerController.value.duration}");
      print("🎞 AspectRatio: ${videoPlayerController.value.aspectRatio}");

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false,
        allowMuting: true,
        allowFullScreen: true,
        showControls: true,
        aspectRatio: videoPlayerController.value.aspectRatio > 0
            ? videoPlayerController.value.aspectRatio
            : 16 / 9,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.redAccent,
          handleColor: Colors.white,
          backgroundColor: Colors.black54,
          bufferedColor: Colors.grey,
        ),
        errorBuilder: (context, errorMessage) {
          print("⚠️ Chewie Error: $errorMessage");
          return Center(
            child: Text(
              "⚠️ Error loading video\n$errorMessage",
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          );
        },
      );

      isVideoInitialized.value = true;
      isPlaying.value = videoPlayerController.value.isPlaying;

      // Add listener
      videoPlayerController.addListener(() {
        isPlaying.value = videoPlayerController.value.isPlaying;
      });

      print("🎉 Step 5: Video ready for playback!");
    } catch (e, s) {
      print("❌ Exception during initialization: $e");
      print("🧾 Stacktrace:\n$s");

      Get.snackbar(
        "Playback Error",
        e.toString(),
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        colorText: Colors.white,
      );

      isVideoInitialized.value = false;
    }
  }

  /// Assign URLs
  Future<void> setUrls({String? video, String? trailer}) async {
    print("📥 Received URLs from API:");
    print("   ▶️ Video: ${video ?? 'N/A'}");
    print("   🎬 Trailer: ${trailer ?? 'N/A'}");

    videoUrl = (video ?? '').trim();
    trailerUrl = (trailer ?? '').trim();

    if (hasVideo) {
      print("🎞 Detected playable video URL, initializing player...");
      await initializeVideo(videoUrl!);
    } else if (hasTrailer) {
      print("📺 Detected YouTube trailer only — skipping native player init.");
      isVideoInitialized.value = false;
    } else {
      print("🚫 No video or trailer URLs found.");
      isVideoInitialized.value = false;
    }
  }

  bool get hasVideo => videoUrl != null && videoUrl!.isNotEmpty;
  bool get hasTrailer => trailerUrl != null && trailerUrl!.isNotEmpty;

  void toggleMute() {
    if (!isVideoInitialized.value) {
      print("🚫 toggleMute called before initialization.");
      return;
    }
    if (isMuted.value) {
      print("🔊 Unmuting video...");
      videoPlayerController.setVolume(1.0);
    } else {
      print("🔇 Muting video...");
      videoPlayerController.setVolume(0.0);
    }
    isMuted.toggle();
  }

  void togglePlayPause() {
    if (!isVideoInitialized.value) {
      print("🚫 togglePlayPause called before initialization.");
      return;
    }
    if (videoPlayerController.value.isPlaying) {
      print("⏸ Pausing video...");
      videoPlayerController.pause();
      isPlaying.value = false;
    } else {
      print("▶️ Playing video...");
      videoPlayerController.play();
      isPlaying.value = true;
    }
  }

  @override
  void onClose() {
    print("🧹 Cleaning up video resources...");
    try {
      if (isVideoInitialized.value) {
        videoPlayerController.dispose();
      }
      chewieController?.dispose();
      print("✅ Video controllers disposed.");
    } catch (e) {
      print("⚠️ Dispose error: $e");
    }
    super.onClose();
  }
}
