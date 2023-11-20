import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mini_social/components/network_image_video_view.dart';
import 'package:flutter_mini_social/repositories/post_repositories.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.post,
  });

  final QueryDocumentSnapshot<Object?> post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(bottom: 16, top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      post['poster_id'],
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          convertTimestampToString(post["created_at"]),
                          style: TextStyle(
                              fontSize: 12,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz))
                      ],
                    )
                  ],
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      // if (post.data().toString().contains('ImageUrl'))
                      VerticalDivider(
                        thickness: 1,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post['content'],
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              if (post.data().toString().contains('file_url'))
                                Container(
                                  constraints: BoxConstraints(
                                    // maxWidth:
                                    //     MediaQuery.of(context).size.width * 0.75,
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.35,
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: PostImageVideoView(
                                        fileType: post['post_type'],
                                        fileUrl: post['file_url'],
                                      )),
                                ),
                              SizedBox(
                                height:
                                    post.data().toString().contains('file_url')
                                        ? 16
                                        : 8,
                              ),
                              BottomItem(
                                post: post,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
        Divider(
          height: 2,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }
}

class BottomItem extends StatelessWidget {
  const BottomItem({
    super.key,
    required this.post,
  });

  final QueryDocumentSnapshot<Object?> post;

  @override
  Widget build(BuildContext context) {
    var isLiked =
        post['likes'].contains(FirebaseAuth.instance.currentUser!.email);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                PostRepository().likeOrDislikePost(
                    likes: List<String>.from(post['likes'] ?? []), postId: post['post_id']);
              },
              child: isLiked
                  ? Image.asset(
                      'assets/icons/ic_heart_full.png',
                      height: 24,
                      width: 24,
                    )
                  : Image.asset(
                      'assets/icons/ic_heart_blank.png',
                      height: 24,
                      width: 24,
                    ),
            ),
            const SizedBox(
              width: 16,
            ),
            GestureDetector(
                onTap: () {},
                child: Image.asset(
                  'assets/icons/ic_comment.png',
                  height: 24,
                  width: 24,
                )),
          ],
        ),
        if (post['likes'].length > 0)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('${post['likes'].length} likes'),
          )
      ],
    );
  }
}

String convertTimestampToString(dynamic item) {
  DateTime datetime = DateTime.fromMillisecondsSinceEpoch(item);
  // DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  // String string = dateFormat.format(datetime);
  String timeNoti = convertToAgoBase(datetime);

  return timeNoti;
}

// bool checkTime(DateTime createData) {
//     DateTime newTime = createData.toLocal().add(createData.toLocal().timeZoneOffset);
//     DateTime systemTime = DateTime.now();
//     String timeNoti = convertToAgoBase(newTime);
//     if (systemTime.difference(newTime).inHours < 24) {
//       return true;
//     } else {
//       return false;
//     }
//   }

String convertToAgoBase(DateTime input) {
  Duration diff = DateTime.now().difference(input);

  if (diff.inDays >= 1) {
    return "${diff.inDays}d";
  } else if (diff.inHours >= 1) {
    return "${diff.inHours}h";
  } else if (diff.inMinutes >= 1) {
    return "${diff.inMinutes}min";
  } else {
    return "just now";
  }
}
