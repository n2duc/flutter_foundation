import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    this.starCount = 5,
    this.rating = 0.0,
    this.color,
    this.starSize = RFXSpacing.spacing18,
  });

  final int starCount;
  final double rating;
  final Color? color;
  final double starSize;

  Widget buildStar(final BuildContext context, final int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        size: starSize,
        color: RFXColors.lightOutline,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(Icons.star_half, size: starSize, color: Colors.amber);
    } else {
      icon = Icon(Icons.star, size: starSize, color: Colors.amber);
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        starCount,
        (final index) => buildStar(context, index),
      ),
    );
  }
}
