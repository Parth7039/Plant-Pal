import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medigard/text_box.dart';

import 'homepage.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final currentUser = FirebaseAuth.instance.currentUser!;

  Future<void> editField(String field) async{

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          title: Text('Profile',style: TextStyle(color: Colors.white),),
          leading:
          IconButton(onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()) );}, icon: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,),)
      ),
      body: ListView(
        children: [
          SizedBox(height: 15,),
          Icon(Icons.person,size: 100,),
          Text(currentUser.email!,textAlign: TextAlign.center,),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('My Details'),
          ),
          SizedBox(height: 15,),
          MyTextBox(text: 'Parth Bhamare', sectionName: 'Username', onPressed: () => editField('username'),),
          MyTextBox(text: 'Rose, Lily', sectionName: 'Liked Plants', onPressed: () => editField('Liked Plants'),),
        ],
      )
    );
  }
}
