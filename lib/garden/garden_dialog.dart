import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medigard/garden/creategarden.dart';
import 'package:slide_to_act/slide_to_act.dart';

class GardendialogBox extends StatelessWidget {
  final TextEditingController controller;

  const GardendialogBox({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: "Enter name",
              ),
            ),
            SizedBox(height: 50,),
            ElevatedButton(
              onPressed: () {
                // Navigate to createGarden with the text from the TextField
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => createGarden(name: controller.text)),
                );
              },
              child: Text('Next', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
