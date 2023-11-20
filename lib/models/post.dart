import 'package:flutter/foundation.dart' show immutable;

import '../core/constants/firebase_field_names.dart';

@immutable
class Post {
  final String postId;
  final String posterId;
  final String content;
  final String fileUrl;
  final String postType;
  final DateTime createAt;
  final List<String> likes;

  const Post(
      {required this.postId,
      required this.posterId,
      required this.content,
      required this.fileUrl,
      required this.postType,
      required this.createAt,
      required this.likes});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirebaseFieldNames.postId: postId,
      FirebaseFieldNames.posterId: posterId,
      FirebaseFieldNames.content: content,
      FirebaseFieldNames.fileUrl: fileUrl,
      FirebaseFieldNames.postType: postType,
      FirebaseFieldNames.createdAt: createAt.millisecondsSinceEpoch,
      FirebaseFieldNames.likes: likes
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
        postId: map[FirebaseFieldNames.postId] ?? '',
        posterId: map[FirebaseFieldNames.posterId] ?? '',
        content: map[FirebaseFieldNames.content] ?? '',
        fileUrl: map[FirebaseFieldNames.fileUrl] ?? '',
        postType: map[FirebaseFieldNames.postType] ?? '',
        createAt: DateTime.fromMillisecondsSinceEpoch(
            map[FirebaseFieldNames.postId] ?? 0),
        likes: List<String>.from(map[FirebaseFieldNames.likes] ?? []));
  }
}
