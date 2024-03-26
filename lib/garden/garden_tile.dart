import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medigard/garden/view_garden.dart';
import '../ui_pages/homepage.dart';
import 'garden_dialog.dart';

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
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        ),
        title: const Text('My Gardens', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('gardens').snapshots(),
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

          return ListView.builder(
            itemCount: gardens.length,
            itemBuilder: (context, index) {
              final garden = gardens[index];
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
                    leading: imageUrl != null
                        ? Image.network(imageUrl)
                        : SizedBox(),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                View_GardenPage(
                                  imageUrl: imageUrl ?? '', // Handle null value
                                  gardenName: gardenName ??
                                      '', // Handle null value
                                ),
                          ),
                        );
                      },
                      icon: Icon(Icons.navigate_next_sharp),
                    ),
                    title: Text(gardenName ?? ''),
                    onTap: () {
                      // Handle onTap event
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}