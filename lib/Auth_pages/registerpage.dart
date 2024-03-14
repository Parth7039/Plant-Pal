import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../ui_pages/homepage.dart';
import 'loginpage.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  RegisterPage({Key? key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    Future<void> signUserUp() async {
      try {
        showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          },
        );

        if (passwordController.text == confirmPasswordController.text) {
          UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: usernameController.text,
            password: passwordController.text,
          );

          await _firestore.collection("Users").doc(userCredential.user!.uid).set(
            {
              'uid': userCredential.user!.uid,
              'email': userCredential.user!.email,
            },
          );
        } else {
          print('Passwords do not match');
        }

        // Pop the dialog on success
        Navigator.pop(context);

        // Navigate to the Home Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (e) {
        // Handle sign-up errors here
        print("Error signing up: $e");

        // You can display an error message to the user, for example:
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error signing up")));

        // Pop the dialog in case of an error
        Navigator.pop(context);
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
        Positioned.fill(
        child: Image.asset(
          'assets/images/nature2.jpg',
          fit: BoxFit.cover,
        ),
      ),
        SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Icon(Icons.tag_faces, size: 100),
                  SizedBox(height: 30),
                  const Text(
                    'Let\'s create a new user',
                    style: TextStyle(fontSize: 15,color: Colors.white),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)),
                        fillColor: Colors.transparent.withOpacity(0.5),
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(color: Colors.white),
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)),
                        fillColor: Colors.transparent.withOpacity(0.5),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.white),
                        labelText: 'Confirm Password',
                        labelStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)),
                        fillColor: Colors.transparent.withOpacity(0.5),
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: signUserUp,
                    child: Text('Sign Up',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? ', style: TextStyle(color: Colors.white),),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(
                                  onTap: () {},
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Login now.',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
        ),
      ),
    );
  }
}
