import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medigard/ui_pages/collab.dart';
import 'package:medigard/ui_pages/garden.dart';
import 'package:medigard/ui_pages/news.dart';
import 'package:medigard/ui_pages/profile.dart';
import 'package:medigard/ui_pages/search.dart';
import 'package:medigard/ui_pages/task.dart';
import 'package:medigard/ui_pages/weather.dart';
import '../Auth_pages/loginpage.dart';
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 1;

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage(onTap: () {},)));
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.search, size: 30,),
      Icon(Icons.home,size: 30,),
      Icon(Icons.person_pin,size: 30,),
    ];

    final screens = [
      SearchPage(),
      HomePage(),
      ProfilePage(),
    ];
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: navigationKey,
        backgroundColor: Colors.transparent,
        height: 60,
        index: index,
        items: items,
        onTap: (index) => setState(() => this.index = index),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text("Homepage",style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
              onPressed: (){signUserOut(context);},
              icon: Icon(Icons.logout,color: Colors.white,)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: 30),
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("User Profile"),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("User Profile"),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: (
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => WeatherPage()),
                        );
                      },
                      child: Container(
                        height: 170,
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.blue.shade900, width: 5),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Image.asset('assets/images/weather-news.png', height: 100, width: 100),
                            SizedBox(height: 20),
                            Text(
                              'Weather',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => NewsPage()),
                        );
                      },
                      child: Container(
                        height: 170,
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.blue.shade900, width: 5),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Image.asset('assets/images/news.png', height: 120, width: 110),
                            Text(
                              'News & Updates',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => WeatherPage()),
                        );
                      },
                      child: Container(
                        height: 170,
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.blue.shade900, width: 5),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Image.asset('assets/images/shop.png', height: 100, width: 100),
                            SizedBox(height: 20),
                            Text(
                              'Buy Plants!!',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => TaskSchedulePage()),
                        );
                      },
                      child: Container(
                        height: 170,
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.blue.shade900, width: 5),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Image.asset('assets/images/task.png', height: 100, width: 100),
                            SizedBox(height: 20),
                            Text(
                              'Tasks',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
        ),
      )
    );
  }
}