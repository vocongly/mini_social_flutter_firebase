import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mini_social/core/constants/firebase_field_names.dart';
import 'package:flutter_mini_social/models/post.dart';
import 'package:uuid/uuid.dart';

@immutable
class PostRepository {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');


  Future<String?> makePost(
      {required String content,
      required File file,
      required String fileType}) async {
    try {
      final postId = const Uuid().v1();
      final posterId = _auth.currentUser!.email;

      final now = DateTime.now();

      // post file to storage
      final fileId = const Uuid().v1();
      final path = _storage.ref(fileType).child(fileId);
      final takeSnapshot = await path.putFile(file);
      final dowanloadUrl = await takeSnapshot.ref.getDownloadURL();

      Post post = Post(
          postId: postId,
          posterId: posterId!,
          content: content,
          fileUrl: dowanloadUrl,
          postType: fileType,
          createAt: now,
          likes: []);

      posts.doc(postId).set(post.toMap());

      return null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String?> likeOrDislikePost({postId,required List<String> likes}) async{
    try {
      final posterId = _auth.currentUser!.email;
      if(likes.contains(posterId)){
        posts.doc(postId).update({
          FirebaseFieldNames.likes : FieldValue.arrayRemove([posterId!])
        });
      }else{
        posts.doc(postId).update({
          FirebaseFieldNames.likes : FieldValue.arrayUnion([posterId!])
        });
      }
      return null;
    } catch (e) {
      print(e.toString());
    }
  }
}
