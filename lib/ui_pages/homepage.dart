import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medigard/ui_pages/profile.dart';
import 'package:medigard/ui_pages/search.dart';
import 'package:medigard/ui_pages/task.dart';
import 'package:medigard/ui_pages/weather.dart';
import '../Auth_pages/loginpage.dart';
import 'custom_carousel.dart';
import 'garden.dart';
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

    final List<Map<String, String>> images = [
      {"image": "assets/images/Ajwain.jpg", "title": "Ajwain"},
      {"image": "assets/images/Aloe.webp", "title": "Aloe Vera"},
      {"image": "assets/images/fenugreek.jpg", "title": "Fenugreek"},
      {"image": "assets/images/neem.jpg", "title": "Neem"},
      {"image": "assets/images/tulsi.jpg", "title": "Tulsi"},
      {"image": "assets/images/turmeric.webp", "title": "Turmeric"},
      {"image": "assets/images/Manjistha.webp", "title": "Manjistha"},
      {"image": "assets/images/saffron.jpg", "title": "Saffron"},
      {"image": "assets/images/sandalwood.jpg", "title": "Sandalwood"},
    ];

    return Scaffold(
      backgroundColor: Colors.black,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SearchPage()),
          );
        },
        child: Icon(Icons.search,color: Colors.white,),
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
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 200,
                padding: const EdgeInsets.all(10),
                child: CustomCarousel(
                  visible: 3,
                  borderRadius: 20,
                  slideAnimationDuration: 500,
                  titleFadeAnimationDuration: 300,
                  childClick: (int index) {
                    print("Clicked $index");
                  },
                  children: images,
                ),
              ),
              SizedBox(height: 10,),
              Stack(
                children: [
                  Container(
                    height: 569,
                    width: 450,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                      color: Colors.red.shade400,
                    ),
                  ),
                  Column(
                    children: [
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
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black, width: 5),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 5),
                                  Image.asset('assets/images/weather-news.png', height: 100, width: 100),
                                  SizedBox(height: 20),
                                  Text(
                                    'Weather',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
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
                                MaterialPageRoute(builder: (context) => create_GardenPage()),
                              );
                            },
                            child: Container(
                              height: 170,
                              width: 170,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black, width: 5),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 5),
                                  Image.asset('assets/images/garden.png', height: 120, width: 110),
                                  Text(
                                    'My Garden',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
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
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black, width: 5),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 5),
                                  Image.asset('assets/images/shop.png', height: 100, width: 100),
                                  SizedBox(height: 20),
                                  Text(
                                    'Buy Plants!!',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
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
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black, width: 5),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 5),
                                  Image.asset('assets/images/task.png', height: 100, width: 100),
                                  SizedBox(height: 20),
                                  Text(
                                    'Tasks',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        )
        ),
      )
    );
  }
}