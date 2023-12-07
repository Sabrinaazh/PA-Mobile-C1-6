import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CatCagesPage extends StatelessWidget {
  final List<Map<String, dynamic>> CatCageList = [
    {
      'image': 'assets/cage1.png',
      'price': '280.000',
      'name': 'Pet Cargo Normal'
    },
    {
      'image': 'assets/cage2.png',
      'price': '500.000',
      'name': 'Sleeping Pouch Bentuk Jamur'
    },
    {
      'image': 'assets/cage3.png',
      'price': '350.000',
      'name': 'Pet Cargo Dragable'
    },
    {
      'image': 'assets/cage4.png',
      'price': '400.000',
      'name': 'Sleeping Pouch Motif Stroberi'
    },
    {'image': 'assets/cage5.png', 'price': '150.000', 'name': 'Kandang Kucing'},
    {
      'image': 'assets/cage6.png',
      'price': '72.000',
      'name': 'Kandang Tenda Lipat'
    },
    {'image': 'assets/cage7.png', 'price': '120.000', 'name': 'Kandang Trevel'},
    {'image': 'assets/cage8.png', 'price': '73.000', 'name': 'Snail bed cat'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cage Page',
          style: GoogleFonts.secularOne(),
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.7,
        ),
        itemCount: CatCageList.length,
        itemBuilder: (BuildContext context, int index) {
          return buildCageCard(context, CatCageList[index]);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Handle home button press
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Handle person button press
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCageCard(BuildContext context, Map<String, dynamic> catCage) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CatCageDetailPage(cage: catCage),
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
              height: 130.0,
              child: Image.asset(
                catCage['image'],
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                catCage['name'],
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                'Price: ${catCage['price']}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff5a53aa),
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
                  onPressed: () {
                    // Handle add to cart button press
                  },
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

class CatCageDetailPage extends StatefulWidget {
  final Map<String, dynamic> cage;

  const CatCageDetailPage({Key? key, required this.cage}) : super(key: key);

  @override
  _CatCageDetailPageState createState() => _CatCageDetailPageState();
}

class _CatCageDetailPageState extends State<CatCageDetailPage> {
  int quantity = 1;
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.cage['name'],
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
                      widget.cage['image'],
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
                      'Price: ${widget.cage['price']}',
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
                            'Added to cart: ${widget.cage['name']} - Quantity: $quantity - Rating: $rating');

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
  runApp(
    MaterialApp(
      home: CatCageDetailPage(
        cage: {
          'name': 'Sample Food',
          'image': 'assets/sample_food_image.jpg',
          'price': 10.0,
          'description': 'This is a sample food description.',
        },
      ),
    ),
  );
}
