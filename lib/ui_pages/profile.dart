import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading:
          IconButton(onPressed: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()) );}, icon: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,),)
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {  },
        child: Icon(Icons.edit,color: Colors.white,),
      ),
      body: Center(
        child: Column(
          children: [
            Icon(Icons.person,size: 130,color: Colors.white,),
            SizedBox(height: 5,),
            Text(currentUser.email!,style: TextStyle(color: Colors.white),),
            SizedBox(height: 100,),
            profileContainer('Username'),
            SizedBox(height: 20,),
            profileContainer('Email'),
            SizedBox(height: 20,),
            profileContainer('Mobile'),
          ],
        ),
      ),
    );
  }

  Widget profileContainer(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style: TextStyle(color: Colors.white),),
        Container(
          height: 50,
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
        )
      ],
    );
  }

}