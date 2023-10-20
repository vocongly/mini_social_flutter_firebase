import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.post,
  });

  final QueryDocumentSnapshot<Object?> post;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                width: 1, color: Theme.of(context).colorScheme.inversePrimary)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  post['UserEmail'],
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  convertTimestampToString(post["Timestamp"]),
                  style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.inversePrimary),
                )
              ],
            ),
            Text(
              post['Message'],
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w300),
            ),
          ],
        ));
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



