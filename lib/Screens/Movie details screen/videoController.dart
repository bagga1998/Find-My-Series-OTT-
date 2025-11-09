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

  /// Initialize video safely
Future<void> initializeVideo(String videoUrl) async {
  try {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
      videoPlayerOptions: VideoPlayerOptions(
        allowBackgroundPlayback: false,
        mixWithOthers: false,
      ),
    );

    await videoPlayerController.initialize().timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        throw Exception("Video initialization timed out");
      },
    );

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      allowMuting: true,
      allowFullScreen: true,
      showControls: true,
      aspectRatio: videoPlayerController.value.aspectRatio,
      errorBuilder: (context, errorMessage) {
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
    update();
  } catch (e) {
    print("❌ Video initialization failed: $e");
    Get.snackbar(
      "Playback Error",
      e.toString(),
      backgroundColor: Colors.redAccent.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
}

  /// Toggle mute/unmute
  void toggleMute() {
    if (isMuted.value) {
      videoPlayerController.setVolume(1.0);
    } else {
      videoPlayerController.setVolume(0.0);
    }
    isMuted.toggle();
  }

  /// Toggle play/pause
  void togglePlayPause() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
      isPlaying.value = false;
    } else {
      videoPlayerController.play();
      isPlaying.value = true;
    }
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.onClose();
  }
}
