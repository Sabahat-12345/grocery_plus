import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartWidget extends StatelessWidget {
    final String name;
  final String image;
  final String rating;
  final String price;

  const CartWidget({
    super.key,
     required this.image,
    required this.name,
    required this.rating,
    required this.price,
  });
  // Removed duplicate unnamed constructor
  

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  image,
                  height: 60,
                  width: 60,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rating: $rating",
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "\$$price",
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ],
            ),
            const Icon(Icons.delete),
          ],
        ),
      ),
    );
  }
}