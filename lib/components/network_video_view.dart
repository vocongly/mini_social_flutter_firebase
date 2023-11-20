import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';

class NetworkVideoView extends StatefulWidget {
  const NetworkVideoView({
    super.key,
    required this.videoUrl,
  });

  final String videoUrl;

  @override
  State<NetworkVideoView> createState() => _NetworkVideoViewState();
}

class _NetworkVideoViewState extends State<NetworkVideoView> {
  late final VideoPlayerController _videoController;

  bool isPlaying = false;

  bool isMuted = false;

  bool isClicked = false;

  @override
  void initState() {
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.videoUrl,
      ),
    )
      ..setLooping(true)
      ..initialize().then((value) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _videoController.value.aspectRatio,
      child: Stack(
        children: [
          VideoPlayer(_videoController),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: isClicked ? 0.0 : 1.0,
              duration: const Duration(seconds: 1),
              child: IconButton(
                onPressed: () {
                  isClicked = !isClicked;
                  if (isPlaying) {
                    _videoController.pause();
                  } else {
                    _videoController.play();
                  }
                  isPlaying = !isPlaying;
                  setState(() {});
                },
                icon: Icon(
                  isPlaying ? Icons.pause_circle : Icons.play_circle,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  if (isMuted) {
                    _videoController.setVolume(1.0);
                  } else {
                    _videoController.setVolume(0.0);
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
