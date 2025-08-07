import 'dart:io';

class Food {
  final String name;
  final String description;
  final double rating;
  final int reviews;
  final String image;
  final double price;
  final File? imageFile; // For picked images from device

  Food({
    required this.name,
    required this.description,
    required this.rating,
    required this.reviews,
    required this.image,
    required this.price,
    this.imageFile,
  });

  // Helper method to check if we should use file or asset
  bool get hasImageFile => imageFile != null;
}
