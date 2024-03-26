import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:medigard/drawer.dart';
import 'package:medigard/ui_pages/gallery.dart';
import 'package:medigard/ui_pages/guide.dart';
import 'package:medigard/ui_pages/profile.dart';
import 'package:medigard/ui_pages/search.dart';
import 'package:medigard/tasks/task.dart';
import 'package:medigard/ui_pages/weather.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Auth_pages/loginpage.dart';
import 'custom_carousel.dart';
import '../garden/garden.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  int index = 1;

  @override
  void initState() {
    super.initState();
    _checkIfDialogHasBeenShown();
  }

  Future<void> _checkIfDialogHasBeenShown() async {
    final prefs = await SharedPreferences.getInstance();
    final hasShownDialog = prefs.getBool('hasShownDialog') ?? false;
    if (!hasShownDialog) {
      prefs.setBool('hasShownDialog', true);
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Make sure to update the Profile and Garden details',style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: Container(
                        height: 40,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            borderRadius: BorderRadius.circular(11)
                        ),
                        child: Center(child: Text('Ok',style: TextStyle(color: Colors.white,fontSize: 15))),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      });
    }
  }

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(onTap: () {})),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          "Let's plough it!!",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              signUserOut(context);
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
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
        child: Icon(Icons.search, color: Colors.white),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
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
            SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  height: 650,
                  width: 450,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WeatherPage(),
                              ),
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
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Garden_displayPage(),
                              ),
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
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WeatherPage(),
                              ),
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
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskSchedulePage(),
                              ),
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
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GuidePage(),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade900,
                          border: Border.all(color: Colors.black,width: 5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/images/guide.png',width: 80,height: 100,),
                            Text('Your Guide',style: TextStyle(color: Colors.white,fontSize: 25),),
                            Icon(Icons.arrow_circle_right,color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GalleryPage(),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 350,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade900,
                            border: Border.all(color: Colors.black,width: 5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/images/gallery.png',width: 80,height: 100,),
                            Text('Gallery',style: TextStyle(color: Colors.white,fontSize: 25),),
                            Icon(Icons.arrow_circle_right,color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
