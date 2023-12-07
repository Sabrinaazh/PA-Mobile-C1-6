import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Tas extends StatelessWidget {
  final List<Map<String, dynamic>> tasList = [
    {'image': 'assets/bag1.png', 'price': '108.000', 'name': 'Pet Carrier Bag'},
    {'image': 'assets/bag2.png', 'price': '112.000', 'name': 'Pet Travel Bag'},
    {
      'image': 'assets/bag3.png',
      'price': '120.000',
      'name': 'Tas kucing transparan'
    },
    {
      'image': 'assets/bag4.png',
      'price': '30.000',
      'name': 'Copper Travel Bag'
    },
    {'image': 'assets/bag5.png', 'price': '97.000', 'name': 'Backpack Bag pet'},
    {'image': 'assets/bag6.png', 'price': '130.000', 'name': 'Box Pet Bag'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pet Tas',
          style: GoogleFonts.secularOne(),
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.8,
        ),
        itemCount: tasList.length,
        itemBuilder: (BuildContext context, int index) {
          return buildTasCard(context, tasList[index]);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTasCard(BuildContext context, Map<String, dynamic> tas) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TasDetailPage(Pettas: tas),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 220.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Color(0xffe9dcf5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 100.0,
              child: Image.asset(
                tas['image'],
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                tas['name'],
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                'Price: Rp. ${tas['price']}',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff5a53aa),
                  ),
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  backgroundColor: Color(0xff5a53aa),
                  onPressed: () {},
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
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

class TasDetailPage extends StatefulWidget {
  final Map<String, dynamic> Pettas;

  const TasDetailPage({Key? key, required this.Pettas}) : super(key: key);

  @override
  _TasDetailPageState createState() => _TasDetailPageState();
}

class _TasDetailPageState extends State<TasDetailPage> {
  int quantity = 1;
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.Pettas['name'],
          style: GoogleFonts.secularOne(),
        ),
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
                    width: 200.0,
                    height: 200.0,
                    child: Image.asset(
                      widget.Pettas['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100.0), // Add some vertical spacing here
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Color(0xff5a53aa),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Price: ${widget.Pettas['price']}',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Description: This is a fun and engaging toy for your furry friend.',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 16.0,
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
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
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
                            'Added to cart: ${widget.Pettas['name']} - Quantity: $quantity - Rating: $rating');

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
  }
}

void main() {
  runApp(MaterialApp(
    home: Tas(),
  ));
}
