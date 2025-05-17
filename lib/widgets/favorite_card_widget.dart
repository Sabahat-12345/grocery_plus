import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_plus/models/grocery_model.dart';
import 'package:grocery_plus/constants/colors.dart';

class FavoriteCardWidget extends StatelessWidget {
  final Items items;
  final Function() onDelete;
  const FavoriteCardWidget(
      {super.key, required this.items, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    debugPrint("this is user profile:${items.imageUrl}");
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Side: Image + Info
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    items.imageUrl,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items.name,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Rating: 5",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      "\$${items.price}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Right Side: Icons
            Column(
              children: [
                InkWell(
                    onTap: onDelete,
                    child: Icon(Icons.delete, color: AppColors.primaryColor)),
                const SizedBox(height: 10),
                Icon(Icons.shopping_cart, color: AppColors.primaryColor),
              ],
            )
          ],
        ),
      ),
    );
  }
}