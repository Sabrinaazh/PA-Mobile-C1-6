import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class productDetail extends StatefulWidget {
  final String id;

  const productDetail({required this.id});

  @override
  _productDetailState createState() => _productDetailState();
}

class _productDetailState extends State<productDetail> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int quantity = 1;
  double rating = 0.0;

  late Stream<DocumentSnapshot> documentStream;

  @override
  void initState() {
    super.initState();
    documentStream =
        firestore.collection('item').doc(widget.id.toString()).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: documentStream,
      builder: (context, snapshot) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

        return Scaffold(
          backgroundColor: Color.fromARGB(255, 233, 211, 255),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(0, 0, 0, 0),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(60.0), // Add padding here
                      child: SizedBox(
                        width: 250.0,
                        height: 250.0,
                        child: Image.asset(
                          data['image'],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ), // Add some vertical spacing here
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          data['name'].toString(),
                          style: GoogleFonts.secularOne(
                              fontSize: 24,
                              color: Color.fromARGB(255, 90, 83, 170)),
                        ),
                        Text(
                          'Price: Rp.${data['price']}',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity -= 1;
                                  }
                                });
                              },
                            ),
                            Text(
                              ' $quantity',
                              style: GoogleFonts.inter(
                                fontSize: 16.0,
                                color: Color.fromARGB(255, 90, 83, 170),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  quantity += 1;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        RatingBar.builder(
                          initialRating: rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 30.0,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (newRating) {
                            setState(() {
                              rating = newRating;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            // Add your logic for adding the product to the cart or performing any other action
                            // You can use the 'widget.food', 'quantity', and 'rating' values
                            // to process the selected product, quantity, and rating
                            print(
                                'Added to cart: ${data['name']} - Quantity: $quantity - Rating: $rating');

                            // You can also navigate back to the previous screen or perform any other navigation action
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Add to Cart',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
