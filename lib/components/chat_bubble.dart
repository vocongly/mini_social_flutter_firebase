import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.data,
    required this.isSender,
  });

  final Map<String, dynamic> data;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSender
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary),
        child: Text(data['message']));
  }
}
