import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mini_social/components/network_video_view.dart';


class PostImageVideoView extends StatelessWidget {
  const PostImageVideoView({
    Key? key,
    required this.fileType,
    required this.fileUrl,
  }) : super(key: key);

  final String fileType;
  final String fileUrl;

  @override
  Widget build(BuildContext context) {
    if (fileType == 'image') {
      return CachedNetworkImage(
          imageUrl: fileUrl,
          placeholder: (context, url) => Container(
              color: Theme.of(context).colorScheme.secondary,
              height: 200,
              width: 100,
              child: const Center(child: CircularProgressIndicator())),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
    } else {
      return NetworkVideoView(
        videoUrl: fileUrl,
      );
    }
  }
}