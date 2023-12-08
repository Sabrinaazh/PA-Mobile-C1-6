import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/MyHomePage.dart';

class favoritePage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String? _currentUserEmail = _auth.currentUser?.email ?? '';
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference favorite = firestore.collection("favorite");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: GoogleFonts.secularOne(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: favorite
                  .where('email', isEqualTo: _currentUserEmail)
                  .snapshots(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading favorites.\nPlease try again later.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(color: Colors.red),
                    ),
                  );
                } else {
                  var favoriteDocs = snapshot.data!.docs;

                  if (favoriteDocs.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            'Your favorite list is empty.',
                            style: GoogleFonts.inter(fontSize: 18),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()),
                                );
                              },
                              child: Text(
                                "Back",
                                style: GoogleFonts.inter(),
                              ))
                        ],
                      ),
                    );
                  }

                  return Wrap(
                    spacing: 30.0,
                    alignment: WrapAlignment.center,
                    runSpacing: 30.0,
                    children: favoriteDocs
                        .map(
                          (e) => Container(
                            width: 180,
                            height: 300,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 197, 168, 226),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Add a local Image asset
                                      Center(
                                        child: Image.asset(
                                          e.get(
                                              'gambar'), // Replace with your local image asset path
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      SizedBox(
                                          height:
                                              10), // Add some space between image and text

                                      // Add product name
                                      Text(
                                        e.get('nama'),
                                        style: GoogleFonts.secularOne(
                                            textStyle: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        )),
                                      ),

                                      SizedBox(
                                          height:
                                              5), // Add some space between text elements

                                      // Add product price
                                      Text(
                                        'Rp.${e.get("harga")}',
                                        style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                          color: Colors.green.shade900,
                                          fontSize: 14,
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 3,
                                  right: 0,
                                  child: TextButton(
                                    onPressed: () {
                                      favorite.doc(e.id).delete();
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: Color.fromARGB(255, 248, 242, 255),
                                      size: 20,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Color(0xff5a53aa),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
