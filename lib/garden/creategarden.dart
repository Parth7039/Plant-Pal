import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'garden.dart'; // Import Firestore

class createGarden extends StatefulWidget {
  final String name;

  const createGarden({Key? key, required this.name}) : super(key: key);

  @override
  State<createGarden> createState() => _createGardenState();
}

class _createGardenState extends State<createGarden> {
  XFile? _image;
  late final TextEditingController controller1;
  late final TextEditingController controller2;
  late final TextEditingController controller3;

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
  }

  Future<void> _pickImage(ImageSource source) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: source);
    setState(() {
      _image = pickedImage;
    });
  }

  Future<void> _submitData() async {
    final plantName = controller1.text;
    final length = controller2.text;
    final width = controller3.text;

    // Check if all required fields are filled
    if (plantName.isEmpty || length.isEmpty || width.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please fill all the fields',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    } else if (_image == null) {
      Fluttertoast.showToast(
        msg: 'Please select an image',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      return;
    }

    try {
      // Check if the garden already exists
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final existingGardens = await FirebaseFirestore.instance
            .collection('gardens')
            .where('userId', isEqualTo: currentUser.uid)
            .where('plantName', isEqualTo: plantName)
            .where('length', isEqualTo: length)
            .where('width', isEqualTo: width)
            .get();

        if (existingGardens.docs.isNotEmpty) {
          // Garden with the same details already exists
          Fluttertoast.showToast(
            msg: 'This garden already exists',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
          return;
        }
      }

      // Upload image to Firebase Storage
      final FirebaseStorage storage = FirebaseStorage.instance;
      final Reference storageReference = storage.ref().child('images/${DateTime.now()}.png');
      final uploadTask = storageReference.putFile(File(_image!.path));
      await uploadTask.whenComplete(() => print('Image uploaded'));
      final imageUrl = await storageReference.getDownloadURL();

      // Save data to Firestore
      if (currentUser != null) {
        final CollectionReference gardensCollection = FirebaseFirestore.instance.collection('gardens');
        await gardensCollection.add({
          'userId': currentUser.uid, // Save the user ID
          'garden_name' : widget.name,
          'plantName': plantName,
          'length': length,
          'width': width,
          'soilType': dropdownValue, // Include the selected value of the dropdown
          'imageUrl': imageUrl,
        });

        print('Data saved to Firestore');

        // Navigate to Garden_displayPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Garden_displayPage()),
        );
      } else {
        print('User not logged in');
      }
    } catch (error) {
      print('Failed to save data: $error');
    }
  }



  String dropdownValue = 'Soils';
  List<String> _items = ['Soils', 'Clay Soil', 'Sandy Soil', 'Silty Soil', 'Peaty Soil', 'Chalky Soil', 'Loamy Soil'];
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
                  controller: controller1,
                  decoration: InputDecoration(
                      labelText: 'Plants',
                      hintText: 'Name of plants in your garden',
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: controller2,
                        decoration: InputDecoration(
                          labelText: 'Length',
                          hintText: 'in foot!!',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: controller3,
                        decoration: InputDecoration(
                          labelText: 'Width',
                          hintText: 'in foot!!',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    DropdownButton<String>(
                      onTap: _submitData,
                      focusColor: Colors.black,
                      dropdownColor: Colors.grey.shade500,
                      borderRadius: BorderRadius.circular(15),
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      style: TextStyle(color: Colors.grey.shade900),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue ?? dropdownValue; // Use the current value if newValue is null
                        });
                      },
                      items: _items.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                )

              ),
              SizedBox(height: 150,),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: SlideAction(
                  borderRadius: 20,
                  innerColor: Colors.black,
                  outerColor: Colors.white,
                  text: "Create a Garden",
                  textStyle: TextStyle(fontSize: 17),
                  textColor: Colors.black,
                  sliderButtonIcon: const Icon(Icons.grass,color: Colors.white,),
                  sliderRotate: false,
                  onSubmit: _submitData, // Call _submitData function when SlideAction is submitted
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
