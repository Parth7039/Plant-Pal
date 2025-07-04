import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:medigard/ui_pages/homepage.dart';

import 'Mess.dart';

class ConversationList extends StatefulWidget {
  const ConversationList({super.key});

  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CometChatConversations(
          showBackButton: true,
          backButton: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          }, icon: Icon(Icons.arrow_back_ios_new_rounded)),
          onItemTap: (conversation) {

            final target = conversation.conversationWith;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MessagesScreen(
                  user: target is User ? target : null,
                  group: target is Group ? target : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
