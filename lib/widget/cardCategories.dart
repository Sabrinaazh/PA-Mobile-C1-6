import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class cardCategories extends StatefulWidget {
  final Function()? onTap;
  final String? title;
  final IconData? icon;

  const cardCategories(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.title});

  @override
  State<cardCategories> createState() => _cardCategoriesState();
}

class _cardCategoriesState extends State<cardCategories> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
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
            Icon(
              widget.icon,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Text(
              widget.title.toString(),
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
    );
  }
}
