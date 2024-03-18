import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:medigard/ui_pages/images.dart';
import 'package:path/path.dart' as path;

import 'homepage.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key? key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<File>? files = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: pickFiles,
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: files!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemBuilder: (context, index) {
                return GridTile(
                  child: Image.file(files![index], fit: BoxFit.cover),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  uploadFiles(files!);
                  clearGridView(); // Call function to clear GridView
                },
                child: Text('Save', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DisplayImagePage()) ); // Call function to clear GridView
                },
                child: Text('View', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  void pickFiles() async {
    try {
      List<File> pickedFiles = [];
      final result = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true);

      if (result != null) {
        for (var file in result.files) {
          final filePath = file.path;
          final fileData = File(filePath!);
          pickedFiles.add(fileData);
        }

        setState(() {
          files = pickedFiles;
        });
      }
    } catch (e) {
      print('Error picking files: $e');
    }
  }

  Future<void> uploadFiles(List<File> files) async {
    try {
      for (var file in files) {
        final fileName = path.basename(file.path);
        final Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');
        final UploadTask uploadTask = storageReference.putFile(file);

        final TaskSnapshot taskSnapshot = await uploadTask;

        final urlDownload = await taskSnapshot.ref.getDownloadURL();
        print('Download URL: $urlDownload');
      }
    } catch (e) {
      print('Error uploading files: $e');
    }
  }

  void clearGridView() {
    setState(() {
      files = [];
    });
  }
}
