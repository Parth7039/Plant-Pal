import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medigard/garden/view_garden.dart';
import '../ui_pages/homepage.dart';
import 'garden_dialog.dart';

Stream<QuerySnapshot>? _getUserGardensStream() {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    return FirebaseFirestore.instance
        .collection('gardens')
        .where('userId', isEqualTo: currentUser.uid)
        .snapshots();
  } else {
    // If user is not logged in, return null
    return null;
  }
}

class GardenTile extends StatelessWidget {
  const GardenTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => GardendialogBox(controller: controller),
          );
        },
        child: Icon(Icons.add),
      ),

      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        ),
        title: const Text('My Gardens', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: GardenTileState(),
    );
  }
}

class GardenTileState extends StatefulWidget {
  const GardenTileState({Key? key}) : super(key: key);

  @override
  State<GardenTileState> createState() => _GardenTileState();
}

class _GardenTileState extends State<GardenTileState> {
  Stream<QuerySnapshot>? _gardensStream;

  @override
  void initState() {
    super.initState();
    _gardensStream = _getUserGardensStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _gardensStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final gardens = snapshot.data?.docs ?? [];
        final uniqueGardens = _getUniqueGardens(gardens); // Get unique gardens

        return ListView.builder(
          itemCount: uniqueGardens.length,
          itemBuilder: (context, index) {
            final garden = uniqueGardens[index];
            final imageUrl = garden.get('imageUrl') ?? '';
            final gardenName = garden.get('garden_name') ?? '';

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: imageUrl.isNotEmpty
                      ? Image.network(imageUrl)
                      : SizedBox(),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              View_GardenPage(
                                imageUrl: imageUrl,
                                gardenName: gardenName,
                                soil_type: '',
                              ),
                        ),
                      );
                    },
                    icon: Icon(Icons.navigate_next_sharp),
                  ),
                  title: Text(gardenName),
                  onTap: () {
                    // Handle onTap event
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<DocumentSnapshot> _getUniqueGardens(List<DocumentSnapshot> gardens) {
    // Create a set to store unique garden names
    Set<String> uniqueNames = {};
    List<DocumentSnapshot> uniqueGardens = [];

    for (var garden in gardens) {
      final gardenName = garden.get('garden_name') ?? '';
      // Check if the garden name is already present in the set
      if (!uniqueNames.contains(gardenName)) {
        uniqueNames.add(gardenName); // Add the garden name to the set
        uniqueGardens.add(
            garden); // Add the garden to the list of unique gardens
      }
    }

    return uniqueGardens;
  }
}