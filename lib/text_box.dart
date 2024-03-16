import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  void Function()? onPressed;
  MyTextBox({super.key, required this.text, required this.sectionName, required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15)
      ),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(sectionName),
              ),
              IconButton(onPressed: onPressed, icon: Icon(Icons.mode_edit_outlined))
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
