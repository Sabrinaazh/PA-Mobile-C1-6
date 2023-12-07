import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FoodListPage extends StatelessWidget {
  final List<Map<String, dynamic>> foodList = [
    {'image': 'assets/food1.png', 'price': '30.000', 'name': 'Royal Canin Can'},
    {
      'image': 'assets/food2.png',
      'price': '25.000',
      'name': 'Royal Canin Kitten'
    },
    {'image': 'assets/food3.png', 'price': '70.000', 'name': 'Brit Care'},
    {'image': 'assets/food4.png', 'price': '100.000', 'name': 'Woofin Good'},
    {
      'image': 'assets/food5.png',
      'price': '150.000',
      'name': 'Brit Grain Free'
    },
    {'image': 'assets/food6.png', 'price': '130.000', 'name': 'Yarrah'},
    {
      'image': 'assets/food7.png',
      'price': '60.000',
      'name': 'Royal Canin Adult Dog'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pet Food',
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
        itemCount: foodList.length,
        itemBuilder: (BuildContext context, int index) {
          return buildFoodCard(context, foodList[index]);
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

  Widget buildFoodCard(BuildContext context, Map<String, dynamic> food) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodDetailPage(food: food),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Add padding here
                child: Image.asset(
                  food['image'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8.0), // Add some vertical spacing here
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                food['name'],
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
                'Price: ${food['price']}',
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

class FoodDetailPage extends StatefulWidget {
  final Map<String, dynamic> food;

  const FoodDetailPage({Key? key, required this.food}) : super(key: key);

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int quantity = 1;
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.food['name'],
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
                      widget.food['image'],
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
                      'Price: ${widget.food['price']}',
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
                            'Added to cart: ${widget.food['name']} - Quantity: $quantity - Rating: $rating');

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
      home: FoodDetailPage(
        food: {
          'name': 'Sample Food',
          'image': 'assets/sample_food_image.jpg',
          'price': 10.0,
          'description': 'This is a sample food description.',
        },
      ),
    ),
  );
}
