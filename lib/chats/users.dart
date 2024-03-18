import 'package:flutter/material.dart';
import 'package:medigard/ui_pages/homepage.dart';

import 'chat_page.dart';
import 'chat_service.dart';
class ChatUsers extends StatefulWidget {
  const ChatUsers({Key? key});

  @override
  State<ChatUsers> createState() => _ChatUsersState();
}

class _ChatUsersState extends State<ChatUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        }, icon: Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    // Create an instance of ChatService
    ChatService chatService = ChatService();

    return StreamBuilder(
      stream: chatService.getUsersStream(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }

        List<Map<String, dynamic>> users = snapshot.data ?? [];
        return ListView(
          children: users
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"]
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade500,
          borderRadius: BorderRadius.circular(11),
        ),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 20,),
            Text(userData["email"]),
          ],
        ),
      ),
    );
  }
}

