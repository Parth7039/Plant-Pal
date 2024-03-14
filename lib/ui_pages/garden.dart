import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'homepage.dart';
class create_GardenPage extends StatelessWidget {
  const create_GardenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          leading:
          IconButton(onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()) );}, icon: Icon(Icons.arrow_back_ios_new_sharp),)
      ),
      body: Column(
        children: [
          Text("Create garden here"),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child:SlideAction(
                borderRadius: 20,
                innerColor: Colors.black,
                outerColor: Colors.white,
                text: "Create a Garden",
                textColor: Colors.black,
                sliderButtonIcon: const Icon(Icons.grass,color: Colors.white,),
                sliderRotate: false,
                onSubmit: (){
                  print("Garden created");
                },
              )
          )
        ],
      ),
    );
  }
}
