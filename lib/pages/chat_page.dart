import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mini_social/components/chat_bubble.dart';
import 'package:flutter_mini_social/components/chat_component.dart';
import 'package:flutter_mini_social/components/my_textfield.dart';
import 'package:flutter_mini_social/databases/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseDatabase firebaseDatabase = FirebaseDatabase();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final ScrollController _controller = ScrollController();

  String receiverEmail = '';

  bool isMaxScroll = false;

  @override
  void initState() {
    // _controller.addListener(_onScroll);
    // if (_controller.hasClients) {
    //   _controller = ScrollController(
    //       initialScrollOffset: _controller.position.maxScrollExtent);
    // }
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Future.delayed(Duration(milliseconds: 50), () {
    //     _controller.jumpTo(_controller.position.maxScrollExtent);
    //   });
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_controller.hasClients) {
      final position = _controller.position.maxScrollExtent;
      _controller.animateTo(
        position,
        duration: Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    }
  }

  void jumpToMaxScroll() {
    if (_controller.hasClients) {
      final position = _controller.position.maxScrollExtent;
      _controller.animateTo(
        position,
        duration: Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    }
  }

  bool checkControllerPositionMaxScroll() {
    if (_controller.hasClients) {
      final positon = _controller.position.pixels;
      if (positon < _controller.position.maxScrollExtent) {
        return false;
      }
    }
    return true;
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
          Expanded(
              child: Stack(
            children: [
              _buildListMessage(),
              // Visibility(
              //   visible: !isMaxScroll,
              //   child: Positioned(
              //     bottom: 0,
              //     right: MediaQuery.of(context).size.width * 0.45,
              //     child: IconButton(
              //         onPressed: jumpToMaxScroll,
              //         icon: Container(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(50),
              //               color: Theme.of(context).colorScheme.background,
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: Theme.of(context)
              //                       .colorScheme
              //                       .inversePrimary,
              //                   spreadRadius: 1,
              //                   blurRadius: 2,
              //                   offset: const Offset(
              //                       0, 3), // changes position of shadow
              //                 ),
              //               ],
              //             ),
              //             child:
              //                 Center(child: const Icon(Icons.arrow_downward)))),
              //   ),
              // ),
            ],
          )),
          ChatComponnent(receiverEmail: receiverEmail)
        ],
      ),
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
        return SingleChildScrollView(
          reverse: true,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: messages.length,
              controller: _controller,
              itemBuilder: ((context, index) {
                final message = messages[index];
                return _buildMessageItem(message);
              })),
        );
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
              isSender: (data['senderEmail'] == firebaseAuth.currentUser!.email)
                  ? true
                  : false,
            ),
          ],
        ),
      ),
    );
  }
}
