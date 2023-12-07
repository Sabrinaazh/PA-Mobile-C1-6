import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/productDetail.dart';
import 'package:petshop/widget/myItem.dart';

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

class PopularProductsPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference item = firestore.collection("item");
    String? _currentUserEmail = _auth.currentUser?.email ?? '';
    CollectionReference favorite = firestore.collection('favorite');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Popular Product',
          style: GoogleFonts.secularOne(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: item.where('popular', isEqualTo: true).snapshots(),
              builder: (_, snapshot) {
                return (snapshot.hasData)
                    ? Wrap(
                        spacing: 30.0,
                        alignment: WrapAlignment.center,
                        runSpacing: 30.0,
                        children: snapshot.data!.docs
                            .map(
                              (e) => MyItemCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              productDetail(id: e.id)));
                                },
                                plus: () {
                                  checkItemInCart(e.get('name'), e.get('price'),
                                      e.get('image'));
                                },
                                funFav: () {
                                  favorite.add({
                                    'email': _currentUserEmail,
                                    'gambar': e.get('image'),
                                    'nama': e.get('name'),
                                    'harga': e.get('price'),
                                  });
                                },
                                favorite: Icons.favorite_border_outlined,
                                imagePath: e.get('image'),
                                harga: e.get('price'),
                                title: e.get('name'),
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
    );
  }
}
