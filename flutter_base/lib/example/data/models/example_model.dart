class Rating {
  Rating({required this.rate, required this.count});

  final double rate;
  final double count;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: (json["rate"] as num).toDouble(),
    count: (json["count"] as num).toDouble(),
  );
}

class Product {
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.rating,
  });

  final double id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;
  final Rating rating;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: (json["id"] as num).toDouble(),
    title: json["title"],
    description: json["description"],
    price: (json["price"] as num).toDouble(),
    image: json["image"],
    category: json["category"],
    rating: Rating.fromJson(json["rating"]),
  );
}
