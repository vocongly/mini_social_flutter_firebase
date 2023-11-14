import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mini_social/models/message.dart';

class FirebaseDatabase {
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');

  final CollectionReference chats =
      FirebaseFirestore.instance.collection('Chats');

  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'Message': message,
      'Timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getPostsStream() {
    final postStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('Timestamp', descending: true)
        .snapshots();

    return postStream;
  }

  Stream<QuerySnapshot> getPostsByUserEmail(String userEmail){
    final postStream = FirebaseFirestore.instance
        .collection('Posts')
        .where('UserEmail',isEqualTo: userEmail)
        .orderBy('Timestamp', descending: true)
        .snapshots();

    return postStream;
  }

  Future<void> sendMessage(String message, String receiverEmail) async {
    final String senderEmail = user!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderEmail: senderEmail,
        receiverEmail: receiverEmail,
        message: message,
        timestamp: timestamp,
        messageType: MessageType.string);

    List<String> ids = [senderEmail, receiverEmail];
    ids.sort();
    String chatRoomId = ids.join('_');

    await chats.doc(chatRoomId).collection('Messages').add(newMessage.toMap());
  }

  Future<void> sendImage(String url, String receiverEmail) async {
    final String senderEmail = user!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessageImage = Message(
        senderEmail: senderEmail,
        receiverEmail: receiverEmail,
        timestamp: timestamp,
        message: url,
        messageType: MessageType.image);

    List<String> ids = [senderEmail, receiverEmail];
    ids.sort();
    String chatRoomId = ids.join('_');

    await chats.doc(chatRoomId).collection('Messages').add(newMessageImage.toMap());
  }

  Future<void> sendAudio(String url, String receiverEmail) async {
    final String senderEmail = user!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessageImage = Message(
        senderEmail: senderEmail,
        receiverEmail: receiverEmail,
        timestamp: timestamp,
        message: url,
        messageType: MessageType.audio);

    List<String> ids = [senderEmail, receiverEmail];
    ids.sort();
    String chatRoomId = ids.join('_');

    await chats.doc(chatRoomId).collection('Messages').add(newMessageImage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userEmail, String otherUserEmail) {
    List<String> ids = [userEmail, otherUserEmail];
    ids.sort();
    String chatRoomId = ids.join('_');

    return chats
        .doc(chatRoomId)
        .collection('Messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
