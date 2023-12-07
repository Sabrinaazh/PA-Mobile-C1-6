import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class mainan extends StatelessWidget {
  final List<Map<String, dynamic>> toyList = [
    {'image': 'assets/toy1.png', 'price': '20.000', 'name': 'Catnip Mouse'},
    {'image': 'assets/toy2.png', 'price': '15.000', 'name': 'Feather Teaser'},
    {'image': 'assets/toy3.png', 'price': '25.000', 'name': 'Interactive Ball'},
    {'image': 'assets/toy4.png', 'price': '18.000', 'name': 'Sisal Rope Toy'},
    {'image': 'assets/toy5.png', 'price': '22.000', 'name': 'Tunnel Toy'},
    {'image': 'assets/toy6.png', 'price': '30.000', 'name': 'Scratching Post'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Toys',
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
        itemCount: toyList.length,
        itemBuilder: (BuildContext context, int index) {
          return buildToyCard(context, toyList[index]);
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

  Widget buildToyCard(BuildContext context, Map<String, dynamic> toy) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ToyDetailPage(toy: toy),
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
                toy['image'],
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                toy['name'],
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
                'Price: Rp. ${toy['price']}',
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

class ToyDetailPage extends StatefulWidget {
  final Map<String, dynamic> toy;

  const ToyDetailPage({Key? key, required this.toy}) : super(key: key);

  @override
  _ToyDetailPageState createState() => _ToyDetailPageState();
}

class _ToyDetailPageState extends State<ToyDetailPage> {
  int quantity = 1;
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.toy['name'],
          style: GoogleFonts.secularOne(),
        ),
      ),
      body: Padding(
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
                    widget.toy['image'],
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
                    'Price: ${widget.toy['price']}',
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
                          'Added to cart: ${widget.toy['name']} - Quantity: $quantity - Rating: $rating');

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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: mainan(),
  ));
}
                // Add your logic for adding the product to the cart or performing any other
