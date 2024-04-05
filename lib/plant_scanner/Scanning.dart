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

    var apiUrl = Uri.parse('https://plant.id/api/v3/identification?details=access_token,result,classification.suggestions.name,classification.suggestions.probability,classification.suggestions.common_names,watering');
    var request = http.MultipartRequest('POST', apiUrl)
      ..headers['Api-Key'] = _apiKey
      ..files.add(await http.MultipartFile.fromPath('images', _image!.path));

    try {
      var response = await request.send();
      var jsonResponse = await http.Response.fromStream(response).then((response) => jsonDecode(response.body));

      if (jsonResponse['access_token'] != null) {
        setState(() {
          var suggestions = jsonResponse['result']['classification']['suggestions'];
          if (suggestions != null && suggestions.isNotEmpty) {
            // Sort suggestions based on probability in descending order
            suggestions.sort((a, b) => b['probability'].compareTo(a['probability']) as int);

            _result = 'Top 2 Suggestions:\n';
            for (var i = 0; i < suggestions.length && i < 2; i++) {
              var suggestion = suggestions[i];
              var scientificName = suggestion['name'];
              var probability = (suggestion['probability'] * 100).toInt();
              var commonNames = suggestion['common_names']?.join(', ') ?? 'Not available';
              _result += 'Scientific Name: $scientificName\n';
              _result += 'Common Names: $commonNames\n';
              _result += 'Probability: $probability%\n\n';
            }
          } else {
            _result = 'No suggestions found.\n';
          }

          var watering = jsonResponse['result']['watering'];
          if (watering != null) {
            var minWatering = _getWateringLevel(watering['min']);
            var maxWatering = _getWateringLevel(watering['max']);
            _result += 'Watering Preference: $minWatering to $maxWatering\n';
          } else {
            _result += 'Watering preference not available.\n';
          }
        });
      } else {
        setState(() {
          _result = 'No access token found in the response.';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    }
  }

  String _getWateringLevel(int level) {
    switch (level) {
      case 1:
        return 'Dry';
      case 2:
        return 'Medium';
      case 3:
        return 'Wet';
      default:
        return 'Unknown';
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
        title: const Text('Scanner', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
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
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_downward_rounded, size: 60,),
                        Text('Upload Image from below')
                      ],
                    )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(_image!.path),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(_result),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Icon(Icons.photo, size: 35, color: Colors.white),
                          const SizedBox(width: 15),
                          Text('Upload', style: TextStyle(fontSize: 25, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _checkDisease,
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Icon(Icons.photo, size: 35, color: Colors.white),
                          const SizedBox(width: 30),
                          Text('Scan', style: TextStyle(fontSize: 25, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
