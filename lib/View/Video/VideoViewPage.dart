import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:video_player/video_player.dart';

import '../../Controller/VideoController.dart';

class VideoViewPage extends StatefulWidget {
  final file;
  const VideoViewPage({super.key, this.file});

  @override
  State<VideoViewPage> createState() => _VideoViewPageState(file);
}

class _VideoViewPageState extends State<VideoViewPage> {
  // File? currentFile = videoController.videoFile;
  // final temp = VideoPlayerController.file(file);
  late File file;
  late final videoPlayerController;
  _VideoViewPageState(file) {
    videoPlayerController = VideoPlayerController.file(file);
  }

  // VideoPlayerController.asset("assets/video/perfectvideo.mp4");

  late ChewieController chewieController;
  int? bufferDelay;
  int currPlayIndex = 0;

  @override
  void initState() {
    // TODO: implement initState

    // Future.wait([videoPlayerController.initialize()]);
    videoPlayerController.initialize();
    final chewieControllerIn = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      // allowFullScreen: true,
      allowMuting: true,
      allowedScreenSleep: true,
      // aspectRatio:5/8,
      autoInitialize: true,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,

      // subtitle: Subtitles(subtitles),
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),

      hideControlsTimer: const Duration(seconds: 1),
    );
    chewieController = chewieControllerIn;

    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#001E3D'),
      body: Chewie(
        controller: chewieController,
      ),
    );
  }
}
