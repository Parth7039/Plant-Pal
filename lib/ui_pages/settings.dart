import 'package:flutter/material.dart';

import 'homepage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          leading:
          IconButton(onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()) );}, icon: Icon(Icons.arrow_back_ios_new_sharp),)
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text('Reset Password',style: TextStyle(color: Colors.white),),
            ),
          ),
        ),
      ),
    );
  }
}
