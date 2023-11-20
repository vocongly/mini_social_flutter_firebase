import 'dart:async';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_mini_social/components/wave_bubble.dart';
import 'package:flutter_mini_social/models/message.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:link_preview_generator/link_preview_generator.dart';

class ChatBubble extends StatefulWidget {
  const ChatBubble({
    super.key,
    required this.data,
    required this.isSender,
  });

  final Map<String, dynamic> data;
  final bool isSender;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    if (widget.data['messageType'] == MessageType.image.name) {
      return _imageItem(context);
    }
    if (widget.data['messageType'] == MessageType.audio.name) {
      return WaveBubble(
        path: widget.data['message'],
        isSender: widget.isSender,
      );
    }
    return _stringItem(context);
  }

  Container _imageItem(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
        maxHeight: MediaQuery.of(context).size.height * 0.35,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: widget.data['message'],
          placeholder: (context, url) => Container(
              color: Theme.of(context).colorScheme.secondary,
              height: 200,
              width: 100,
              child: const Center(child: CircularProgressIndicator())),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _stringItem(BuildContext context) {
    bool validURL = Uri.parse(widget.data['message']).isAbsolute;
    return validURL
        ? Container(
            margin: const EdgeInsets.only(top: 4),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            child: LinkPreviewGenerator(
              link: widget.data['message'],
              linkPreviewStyle: LinkPreviewStyle.large,
              showGraphic: true,
            ),
          )
        : Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: !widget.isSender
                    ? Border.all(
                        width: 1,
                        color: Theme.of(context).colorScheme.secondary)
                    : null,
                color: widget.isSender
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background),
            child: Text(widget.data['message']));
  }
}
