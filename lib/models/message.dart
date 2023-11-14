import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { string, image, audio }

class Message {
  final String senderEmail;
  final String receiverEmail;
  final String message;
  final Timestamp timestamp;
  final MessageType messageType;

  Message({
    required this.senderEmail,
    required this.receiverEmail,
    required this.message,
    required this.timestamp,
    required this.messageType,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderEmail': senderEmail,
      'receiverEmail': receiverEmail,
      'message': message,
      'timestamp': timestamp,
      'messageType': messageType.name
    };
  }
}
