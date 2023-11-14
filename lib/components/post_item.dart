import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                      post['UserEmail'],
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          convertTimestampToString(post["Timestamp"]),
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
                      if (post.data().toString().contains('ImageUrl'))
                        VerticalDivider(
                          thickness: 1,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: post.data().toString().contains('ImageUrl')
                                  ? 8
                                  : 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post['Message'],
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
                              if (post.data().toString().contains('ImageUrl'))
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
                                    child: CachedNetworkImage(
                                      imageUrl: post['ImageUrl'],
                                      placeholder: (context, url) => Container(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          height: 200,
                                          width: 100,
                                          child: const Center(
                                              child:
                                                  CircularProgressIndicator())),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              SizedBox(
                                height:
                                    post.data().toString().contains('ImageUrl')
                                        ? 16
                                        : 8,
                              ),
                              BottomItem()
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
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ],
    );
  }
}

class BottomItem extends StatefulWidget {
  const BottomItem({
    super.key,
  });

  @override
  State<BottomItem> createState() => _BottomItemState();
}

class _BottomItemState extends State<BottomItem> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isLiked = !isLiked;
            });
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
    );
  }
}

String convertTimestampToString(dynamic item) {
  DateTime datetime =
      DateTime.fromMillisecondsSinceEpoch(item.millisecondsSinceEpoch);
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
