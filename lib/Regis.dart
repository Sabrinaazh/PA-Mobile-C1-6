import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Auth.dart';
import 'Login.dart';

class Regis extends StatefulWidget {
  const Regis({Key? key}) : super(key: key);

  @override
  State<Regis> createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlUsername = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _ctrlEmail.value.text;
    final password = _ctrlPassword.value.text;
    final username = _ctrlUsername.value.text;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");

    setState(() => _loading = true);
    await Auth().regis(email, password);
    users.add({
      'username': username,
    });
    _ctrlEmail.text = '';
    _ctrlPassword.text = '';
    _ctrlUsername.text = '';
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 234, 255),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "REGISTER",
                  style: GoogleFonts.secularOne(
                      textStyle: TextStyle(
                    fontSize: 45,
                    color: Color.fromARGB(255, 170, 173, 246),
                  )),
                ),
                TextFormField(
                  controller: _ctrlEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan Masukkan Email Anda';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    filled: true,
                    hintStyle: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 170, 173, 246))),
                    labelStyle: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 170, 173, 246))),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 170, 173, 246)),
                    ),
                  ),
                  style: GoogleFonts.inter(
                      textStyle:
                          TextStyle(color: Color.fromARGB(255, 170, 173, 246))),
                ),
                SizedBox(height: 25),
                TextFormField(
                  controller: _ctrlUsername,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan Masukkan Username Anda';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Username',
                    filled: true,
                    hintStyle: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 170, 173, 246))),
                    labelStyle: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 170, 173, 246))),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 170, 173, 246)),
                    ),
                  ),
                  style: GoogleFonts.inter(
                      textStyle:
                          TextStyle(color: Color.fromARGB(255, 170, 173, 246))),
                ),
                SizedBox(height: 25),
                TextFormField(
                  controller: _ctrlPassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan Masukkan Password Anda';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                    filled: true,
                    hintStyle: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 170, 173, 246))),
                    labelStyle: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 170, 173, 246))),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 170, 173, 246)),
                    ),
                  ),
                  style: GoogleFonts.inter(
                      textStyle:
                          TextStyle(color: Color.fromARGB(255, 170, 173, 246))),
                ),
                SizedBox(height: 25),
                Container(
                  padding: EdgeInsets.fromLTRB(140, 4, 140, 4),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 90, 83, 170),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextButton(
                    onPressed: () => handleSubmit(),
                    child: _loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                          )
                        : Text(
                            "Create Account",
                            style: GoogleFonts.inter(color: Colors.white),
                          ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  style: TextButton.styleFrom(
                    primary: Color.fromARGB(255, 170, 173, 246),
                  ),
                  child: Text(
                    "Already have an account? Sign In",
                    style: GoogleFonts.inter(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
