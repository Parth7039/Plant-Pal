import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

class MessagesScreen extends StatefulWidget {
  final User? user;
  final Group? group;

  const MessagesScreen({Key? key, this.user, this.group}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CometChatMessageHeader(
        user: widget.user,
        group: widget.group,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CometChatMessageList(
                user: widget.user,
                group: widget.group,
              ),
            ),
            CometChatMessageComposer(
              user: widget.user,
              group: widget.group,
            ),
          ],
        ),
      ),
    );
  }
}