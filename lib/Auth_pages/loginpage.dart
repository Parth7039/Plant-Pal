import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medigard/Auth_pages/registerpage.dart';
import '../ui_pages/homepage.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({Key? key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  Future<void> signUserin() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        },
      );

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernamecontroller.text,
        password: passwordcontroller.text,
      );

      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print("Error signing in: $e");
      Navigator.pop(context);
    }
  }

  Future<void> sendPasswordReset(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: usernamecontroller.text.trim(),
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Password Reset link sent'),
            content: Text('Check your email for instructions'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to send the link'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print('Error sending password reset link: $error');
    }
  }

  Future<bool> checkCredentials() async {
    return usernamecontroller.text.isNotEmpty &&
        passwordcontroller.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock_outlined, size: 100),
                    SizedBox(height: 30),
                    const Text(
                      'Welcome to the Login',
                      style: TextStyle(fontSize: 15,color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: usernamecontroller,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
                    SizedBox(height: 10),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: passwordcontroller,
                      obscureText: true,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(color: Colors.white),
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await sendPasswordReset(context);
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(fontStyle: FontStyle.italic,color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        bool areCredentialsValid =
                        await checkCredentials();

                        if (areCredentialsValid) {
                          await signUserin();
                        } else {
                          print("Invalid credentials");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[800],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Not a member? ', style: TextStyle(color: Colors.white),),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(
                                  onTap: () {},
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Register Now',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
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
