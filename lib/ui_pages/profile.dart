import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../text_box.dart';
import 'homepage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection('Users');

  Future<String?> editField(String field) async {
    String? newValue;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: Text('Edit $field', style: TextStyle(color: Colors.white)),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter $field',
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(context, newValue); // Close the dialog and return the new value
            },
            child: Text('Save'),
          ),
        ],
      ),
    );

    if (newValue != null && newValue!.trim().isNotEmpty) {
      await usersCollection.doc(currentUser.email).update({field: newValue});
      return newValue;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 15),
          Icon(Icons.person, size: 100),
          Text(currentUser.email!, textAlign: TextAlign.center),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('My Details'),
          ),
          SizedBox(height: 15),
          MyTextBox(
            text: currentUser.displayName ?? 'Parth Bhamare',
            sectionName: 'Username',
            onPressed: () async {
              final result = await editField('username');
              if (result != null) {
                setState(() {
                  currentUser.updateDisplayName(result!);
                });
              }
            },
          ),
          MyTextBox(
            text: 'Rose, Lily',
            sectionName: 'Liked Plants',
            onPressed: () async {
              final result = await editField('Liked Plants');
              if (result != null) {
                // Update liked plants logic here
              }
            },
          ),
        ],
      ),
    );
  }
}
