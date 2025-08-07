import 'package:flutter/material.dart';
import 'package:flutter_demo/models/food.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodItem extends StatelessWidget {
  final Food food;
  final void Function() onTap;

  const FoodItem({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Image.asset(food.image, width: 60, height: 60),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber[700], size: 16),
                      const SizedBox(width: 4),
                      Text(
                        food.rating.toString(),
                        style: GoogleFonts.dmSerifDisplay(fontSize: 16),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${food.reviews})',
                        style: GoogleFonts.dmSerifDisplay(fontSize: 16),
                      ),
                    ],
                  ),
                  Text(
                    food.description,
                    style: TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
