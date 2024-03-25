import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'garden.dart';

class createGarden extends StatefulWidget {
  final String name;

  const createGarden({Key? key, required this.name}) : super(key: key);

  @override
  State<createGarden> createState() => _createGardenState();
}

class _createGardenState extends State<createGarden> {
  XFile? _image;

  Future<void> _pickImage(ImageSource source) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: source);
    setState(() {
      _image = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Garden_displayPage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white,),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(widget.name, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              SizedBox(height: 15,),
              Container(
                height: 200,
                width: 380,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: _image == null
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add, size: 50,),
                      onPressed: () {_pickImage(ImageSource.gallery);},
                    ),
                    Text('Add Photo')
                  ],
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                      child: Image.file(
                                      File(_image!.path),
                                      fit: BoxFit.cover,
                                    ),
                    ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Plants',
                    hintText: 'Name of plants in your garden',
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(

                      )
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(

                      )
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(

                      )
                  ),
                ),
              ),
              SizedBox(height: 50,),
              SlideAction(
                borderRadius: 20,
                innerColor: Colors.black,
                outerColor: Colors.white,
                text: "Create a Garden",
                textStyle: TextStyle(fontSize: 17),
                textColor: Colors.black,
                sliderButtonIcon: const Icon(Icons.grass,color: Colors.white,),
                sliderRotate: false,
                onSubmit: (){
                  print("Garden created");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
