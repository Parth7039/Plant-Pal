import 'package:flutter/material.dart';
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({super.key,required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color:isCurrentUser ? Colors.grey.shade500 : Colors.blue
      ),
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.only(top: 5,bottom: 5,right: 5,left: 50),
      child: Text(message,style: TextStyle(color: Colors.white),),
    );
  }
}
