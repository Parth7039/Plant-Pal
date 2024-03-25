import 'package:flutter/material.dart';
import 'package:medigard/garden/garden_dialog.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../ui_pages/homepage.dart';
class Garden_displayPage extends StatefulWidget {
  const Garden_displayPage({super.key});

  @override
  State<Garden_displayPage> createState() => _Garden_displayPageState();
}

class _Garden_displayPageState extends State<Garden_displayPage> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          leading:
          IconButton(onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()) );}, icon: Icon(Icons.arrow_back_ios_new_sharp),)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context) => GardendialogBox(controller: controller),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Text("Create garden here"),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child:Text('ho')
          )
        ],
      ),
    );
  }
}
