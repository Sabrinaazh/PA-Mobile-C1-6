import 'dart:async';

import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petshop/firebase_options.dart';
import 'package:petshop/splash_Screen.dart';

import 'MyHomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Petshop App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () {
        navigateToScreen();
      },
    );
  }

  void navigateToScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          if (FirebaseAuth.instance.currentUser != null) {
            return MyHomePage();
          } else {
            return splashscreen();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 90, 70, 183),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'logo_meowpet.png',
              width: 350,
              height: 350,
            ),
          ],
        ),
      ),
    );
  }
}
