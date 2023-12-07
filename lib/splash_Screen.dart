import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/Login.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 234, 255),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              "Get Started!",
              style: GoogleFonts.secularOne(
                  textStyle: TextStyle(
                      fontSize: 45, color: Color.fromARGB(255, 90, 83, 170))),
            ),
            Image(image: AssetImage("assets/getstart.png")),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 100,
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 90, 83, 170),
          child: Icon(Icons.arrow_forward_rounded, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
