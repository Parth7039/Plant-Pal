import 'package:flutter/material.dart';
import 'homepage.dart';
class TaskSchedulePage extends StatelessWidget {
  const TaskSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          leading:
          IconButton(onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()) );}, icon: Icon(Icons.arrow_back_ios_new_sharp),)
      ),
      body: Center(
        child: Text("Schedule your tasks here"),
      ),
    );
  }
}
