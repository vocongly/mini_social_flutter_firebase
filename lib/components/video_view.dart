import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key, required this.video});

  final File video;

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late final VideoPlayerController _videoPlayerController;

  bool isPlaying = false;
  bool isMuted = false;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.file(widget.video)
      ..setLooping(true)
      ..initialize().then((value) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _videoPlayerController.value.aspectRatio,
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(_videoPlayerController),
          Positioned(
              child: IconButton(
            onPressed: () {
              if (isPlaying) {
                _videoPlayerController.pause();
              } else {
                _videoPlayerController.play();
              }
              isPlaying = !isPlaying;
              setState(() {});
            },
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              size: 50,
              color: Theme.of(context).colorScheme.secondary,
            ),
          )),
          Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  if (isMuted) {
                    _videoPlayerController.setVolume(1.0);
                  } else {
                    _videoPlayerController.setVolume(0.0);
                  }
                  isMuted = !isMuted;
                  setState(() {});
                },
                icon: Icon(
                  isMuted ? Icons.volume_off : Icons.volume_up,
                  size: 30,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ))
        ],
      ),
    );
  }
}
