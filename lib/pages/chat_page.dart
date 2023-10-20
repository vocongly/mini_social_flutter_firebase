import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mini_social/components/chat_bubble.dart';
import 'package:flutter_mini_social/components/my_textfield.dart';
import 'package:flutter_mini_social/databases/firebase_database.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final FirebaseDatabase firebaseDatabase = FirebaseDatabase();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String receiverEmail = '';

  @override
  void initState() {
    super.initState();
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await firebaseDatabase.sendMessage(messageController.text, receiverEmail);
    }
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final agr = ModalRoute.of(context)!.settings.arguments as Map;
    receiverEmail = agr['receiverEmail'];
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Expanded(child: _buildListMessage()),
          _buildTextfieldMessage()
        ],
      ),
    );
  }

  Widget _buildTextfieldMessage() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: MyTextField(
                  hintText: 'Aa',
                  obscureText: false,
                  controller: messageController),
            ),
          ),
        ),
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.send))
      ],
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> _buildListMessage() {
    return StreamBuilder(
      stream: firebaseDatabase.getMessages(
          firebaseAuth.currentUser!.email!, receiverEmail),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data!.docs;
        // return ListView(
        //   children:
        //       snapshot.data!.docs.map((e) => _buildMessageItem(e)).toList(),
        // );
        return ListView.builder(
            itemCount: messages.length,
            itemBuilder: ((context, index) {
              final message = messages[index];
              return _buildMessageItem(message);
            }));
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot message) {
    Map<String, dynamic> data = message.data() as Map<String, dynamic>;

    var alignment = (data['senderEmail'] == firebaseAuth.currentUser!.email)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment:
              (data['senderEmail'] == firebaseAuth.currentUser!.email)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderEmail'] == firebaseAuth.currentUser!.email)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            ChatBubble(
              data: data,
              isSender:
                  (data['senderEmail'] == firebaseAuth.currentUser!.email)
                      ? true
                      : false,
            ),
          ],
        ),
      ),
    );
  }
}
