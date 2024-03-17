import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

import 'homepage.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key? key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<PlatformFile>? files = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: pickFiless,
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
      body: GridView.builder(
        itemCount: files!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemBuilder: (context, index) {
          return GridTile(
            child: Image.network(files![index].path!, fit: BoxFit.cover,),
          );
        },
      ),
    );
  }

  void pickFiless() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (result != null) {
        List<PlatformFile> pickedFiles = result.files;
        setState(() {
          files = pickedFiles;
        });
        uploadFiles(files!);
      }
    } catch (e) {
      print('Error picking files: $e');
    }
  }

  Future<void> uploadFiles(List<PlatformFile> files) async {
    try {
      for (var file in files) {
        final fileName = path.basename(file.name!);
        final Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');
        final fileData = Uint8List.fromList(file.bytes!);

        final UploadTask uploadTask = storageReference.putData(fileData);

        final TaskSnapshot taskSnapshot = await uploadTask;

        final urlDownload = await taskSnapshot.ref.getDownloadURL();
        print('Download URL: $urlDownload');
      }
    } catch (e) {
      print('Error uploading files: $e');
    }
  }
}
