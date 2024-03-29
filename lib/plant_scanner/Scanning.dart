import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../ui_pages/homepage.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  XFile? _image;
  String _result = '';
  final String _apiKey = 'VIc9NC4WJCOqig2kh1utHxFDyffXDV8e4d7BjiwAshwZqSocNw';

  Future<void> _checkDisease() async {
    if (_image == null) {
      setState(() {
        _result = 'Please select an image.';
      });
      return;
    }

    var apiUrl = Uri.parse('https://plant.id/api/v3/identification');
    var request = http.MultipartRequest('POST', apiUrl)
      ..headers['Api-Key'] = _apiKey
      ..files.add(await http.MultipartFile.fromPath('images', _image!.path));

    try {
      var response = await request.send();
      var jsonResponse = await http.Response.fromStream(response).then((response) => jsonDecode(response.body));

      setState(() {
        _result = jsonResponse['suggestions'][0]['id']; // Adjust as per API response structure
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        ),
        title: const Text('Shopify', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 500,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 3),
              ),
              child: _image == null
                  ? const Icon(Icons.arrow_downward_rounded,size: 60,)
                  : ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(_image!.path),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Icon(Icons.photo, size: 35, color: Colors.white),
                    const SizedBox(width: 40),
                    Text('Upload', style: TextStyle(fontSize: 25, color: Colors.white)),
                  ],
                ),
              ),
            ),
            Text(_result),
            GestureDetector(
              onTap: _checkDisease,
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Icon(Icons.photo, size: 35, color: Colors.white),
                    const SizedBox(width: 40),
                    Text('Scan', style: TextStyle(fontSize: 25, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
