import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:medigard/ui_pages/gallery.dart';

import 'homepage.dart';

class DisplayImagePage extends StatefulWidget {
  const DisplayImagePage({Key? key}) : super(key: key);

  @override
  _DisplayImagePageState createState() => _DisplayImagePageState();
}

class _DisplayImagePageState extends State<DisplayImagePage> {
  late List<String> imageUrls = []; // Initialize imageUrls with an empty list
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    fetchImageUrls();
  }

  Future<void> fetchImageUrls() async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child('images');
      final ListResult result = await storageReference.listAll();
      List<String> urls = [];
      for (final ref in result.items) {
        final url = await ref.getDownloadURL();
        urls.add(url);
      }
      setState(() {
        imageUrls = urls;
        isLoading = false; // Set loading state to false when images are loaded
      });
    } catch (e) {
      print('Error fetching image URLs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => GalleryPage()),
            ); // Changed to pop instead of pushReplacement
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,),
        ),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(color: Colors.black,), // Show circular progress indicator when loading
      )
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GridTile(
            child: Image.network(imageUrls[index], fit: BoxFit.cover),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
