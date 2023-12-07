import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyItemCard extends StatefulWidget {
  final Function()? onTap;
  final Function()? plus;
  final Function()? funFav;
  final IconData? favorite;
  final String? imagePath;
  final String? title;
  final int? harga;

  const MyItemCard(
      {super.key,
      required this.onTap,
      required this.favorite,
      required this.funFav,
      required this.plus,
      required this.imagePath,
      required this.harga,
      required this.title});

  @override
  State<MyItemCard> createState() => _MyItemCardState();
}

class _MyItemCardState extends State<MyItemCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 180,
        height: 300,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 233, 221, 245),
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
                      widget.imagePath
                          .toString(), // Replace with your local image asset path
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ),

                  SizedBox(height: 10), // Add some space between image and text

                  // Add product name
                  Text(
                    widget.title.toString(),
                    style: GoogleFonts.secularOne(
                        textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color.fromARGB(255, 90, 83, 170),
                    )),
                  ),

                  SizedBox(height: 5), // Add some space between text elements

                  // Add product price
                  Text(
                    'Rp.${widget.harga.toString()}',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                      color: Color.fromARGB(255, 197, 168, 226),
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
                onPressed: widget.funFav,
                child: Icon(
                  widget.favorite,
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
                  onTap: widget.plus,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0xff5a53aa),
                      borderRadius: BorderRadius.circular(10),
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
    );
  }
}
