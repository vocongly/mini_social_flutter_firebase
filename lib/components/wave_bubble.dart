import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class WaveBubble extends StatefulWidget {
  final bool isSender;
  final String path;

  const WaveBubble({
    Key? key,
    this.isSender = false,
    required this.path,
  }) : super(key: key);

  @override
  State<WaveBubble> createState() => _WaveBubbleState();
}

class _WaveBubbleState extends State<WaveBubble> {
  bool isPlaying = false;

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(
          bottom: 6,
          right: widget.isSender ? 0 : 10,
          top: 6,
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.isSender
              ? const Color(0xFF276bfd)
              : const Color(0xFF343145),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () async {
                isPlaying ? stopAudio() : playAudio();
              },
              icon: Icon(
                isPlaying ? Icons.stop : Icons.play_arrow,
              ),
              color: Colors.white,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  stopAudio() async {
    await player.stop();
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  playAudio() async {
    await player.play(UrlSource(widget.path));
    setState(() {
      isPlaying = !isPlaying;
    });
  }
}
