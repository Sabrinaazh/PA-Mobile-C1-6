import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

final _auth = FirebaseAuth.instance;

class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  Future<List<Item>> getItem() async {
    try {
      final cartRef = FirebaseFirestore.instance.collection('cart');
      String? _currentUserEmail = _auth.currentUser?.email ?? '';
      final querySnapshot =
          await cartRef.where('email', isEqualTo: _currentUserEmail).get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          items.add(
            Item(
              image: doc.get('image'),
              name: doc.get('name'),
              price: doc.get('price'),
              quantity: doc.get('qty'),
            ),
          );
        }
      }
      return items;
    } catch (e) {
      Text('An error occurred: $e');
      return [];
    }
  }

  double get totalPrice =>
      items.fold(0.0, (sum, item) => sum + item.totalPrice);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: GoogleFonts.secularOne(),
        ),
      ),
      body: FutureBuilder<List<Item>>(
        future: getItem(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Item> items = snapshot.data!;
            double totalPrice =
                items.fold(0.0, (sum, item) => sum + item.totalPrice);
            // Rest of your code...
          } else if (snapshot.hasError) {
            return Text('An error occurred: ${snapshot.error}');
          }
          // By default, show a loading spinner.
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Container(
                      width: double.maxFinite,
                      height: 100,
                      child: ListTile(
                        leading: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 233, 221, 245),
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            item.image.toString(),
                          ),
                        ),
                        title: Text(
                          item.name,
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                        subtitle: Text(
                          'Price: \$${item.price} x Quantity: ${item.quantity}',
                          style: GoogleFonts.inter(fontSize: 14),
                        ),
                        trailing: Text(
                          '\$${item.totalPrice}',
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  'Total Price',
                  style: GoogleFonts.inter(),
                ),
                trailing: Text(
                  '\$${totalPrice}',
                  style: GoogleFonts.inter(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print(
                    'Checkout: \$${totalPrice}',
                  );
                },
                child: Text(
                  'Check Out',
                  style: GoogleFonts.inter(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Item {
  final String name;
  final String image;
  final double price;
  final int quantity;

  Item(
      {required this.image,
      required this.name,
      required this.price,
      required this.quantity});

  double get totalPrice => price * quantity;
}

final List<Item> items = [];
