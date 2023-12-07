import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/FavoritePage.dart';
import 'package:petshop/Login.dart';
import 'package:petshop/cart.dart';
import 'package:petshop/productDetail.dart';
import 'package:petshop/profile.dart';
import 'package:petshop/tempatmakanpage.dart';
import 'package:petshop/widget/myItem.dart';
import 'FoodListPage.dart';
import 'PopularProductsPage.dart';
import 'Tas.dart';
import 'mainan.dart';
import 'CatCagePage.dart';
import 'LitterBoxPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the login page when log out is confirmed
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void checkItemInCart(String name, int price, String image) async {
    final cartRef = FirebaseFirestore.instance.collection('cart');
    String? _currentUserEmail = _auth.currentUser?.email ?? '';
    final querySnapshot = await cartRef.where('name', isEqualTo: name).get();
    if (querySnapshot.docs.isNotEmpty) {
      dynamic id;
      dynamic qty;
      QuerySnapshot data = await FirebaseFirestore.instance
          .collection('cart')
          .where('name', isEqualTo: name)
          .get();
      data.docs.forEach(
        (doc) {
          id = doc.id.toString();
          qty = doc.get('qty');
        },
      );
      qty = qty + 1;
      cartRef.doc(id).update({'qty': qty});
    } else {
      cartRef.add({
        'email': _currentUserEmail,
        'name': name,
        'price': price,
        'image': image,
        'qty': 1,
      });
    }
  }

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String? _currentUserEmail = _auth.currentUser?.email ?? '';
    CollectionReference favorite = firestore.collection('favorite');
    CollectionReference item = firestore.collection("item");
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 242, 255),
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color.fromARGB(255, 90, 83, 170)),
          centerTitle: true,
          title: Text(
            'Meow Petshop',
            style: GoogleFonts.secularOne(
                textStyle: TextStyle(color: Color.fromARGB(255, 90, 83, 170)),
                fontWeight: FontWeight.w600),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                  child: Text(
                    'Categories',
                    style: GoogleFonts.secularOne(
                      textStyle: TextStyle(
                        fontSize: 24,
                        color: Colors.purple[800],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            // Aksi yang ingin dilakukan saat container ditekan
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FoodListPage()),
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 197, 168, 226),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/food.png',
                                  width: 40,
                                  height: 40,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Food',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 13),
                        InkWell(
                          onTap: () {
                            // Aksi yang ingin dilakukan saat container ditekan
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => mainan()),
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 197, 168, 226),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/toys.png', // Ganti dengan path gambar Anda
                                  width: 40,
                                  height: 40,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Toys',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 13),
                        InkWell(
                          onTap: () {
                            // Aksi yang ingin dilakukan saat container ditekan
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Tas()),
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 197, 168, 226),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/bag.png', // Ganti dengan path gambar Anda
                                  width: 40,
                                  height: 40,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Bag',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 13),
                        InkWell(
                          onTap: () {
                            // Aksi yang ingin dilakukan saat container ditekan
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => tempatmakanpage()),
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 197, 168, 226),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/bowl.png', // Ganti dengan path gambar Anda
                                  width: 40,
                                  height: 40,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Bowl',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 13),
                        InkWell(
                          onTap: () {
                            // Aksi yang ingin dilakukan saat container ditekan
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LitterBoxPage()),
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 197, 168, 226),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/litterbox.png', // Ganti dengan path gambar Anda
                                  width: 40,
                                  height: 40,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Litter Box',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 13),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CatCagesPage()),
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 197, 168, 226),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/cage.png', // Ganti dengan path gambar Anda
                                  width: 40,
                                  height: 40,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Cat Cage',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15, bottom: 5),
                  child: Text(
                    'Popular',
                    style: GoogleFonts.secularOne(
                      textStyle: TextStyle(
                        fontSize: 24,
                        color: Colors.purple[800],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25, bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PopularProductsPage(),
                                ),
                              );
                            },
                            child: Text(
                              'See All',
                              style: GoogleFonts.epilogue(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.purple[800],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 230,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 248, 242, 255),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: item
                            .where('popular', isEqualTo: true)
                            .limit(5)
                            .snapshots(),
                        builder: (_, snapshot) {
                          return (snapshot.hasData)
                              ? Row(
                                  children: snapshot.data!.docs
                                      .map(
                                        (e) => Padding(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: MyItemCard(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          productDetail(
                                                              id: e.id)));
                                            },
                                            favorite:
                                                Icons.favorite_border_outlined,
                                            funFav: () {
                                              favorite.add({
                                                'email': _currentUserEmail,
                                                'gambar': e.get('image'),
                                                'nama': e.get('name'),
                                                'harga': e.get('price'),
                                              });
                                            },
                                            plus: () {
                                              checkItemInCart(
                                                  e.get('name'),
                                                  e.get('price'),
                                                  e.get('image'));
                                            },
                                            imagePath: e.get('image'),
                                            harga: e.get('price'),
                                            title: e.get('name'),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )
                              : Text(
                                  'Loading...',
                                  style: GoogleFonts.inter(),
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 248, 242, 255),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme:
            IconThemeData(color: Color.fromARGB(255, 90, 83, 170)),
        unselectedIconTheme:
            IconThemeData(color: Color.fromARGB(255, 141, 138, 182)),
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => favoritePage()),
            );
            ;
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => cart()),
            );
            ;
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => profile()),
            );
            ;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
