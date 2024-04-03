import 'package:flutter/material.dart';
import '../guide/PlantDetailsScreen.dart';
import 'homepage.dart';// Assuming you have a homepage.dart file with the required imports and widgets

class GuidePage extends StatelessWidget {
  const GuidePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Guide"),
        backgroundColor: Colors.lightGreen,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: PlantDetailsScreen(), // Display the list of plants here
    );
  }
}
